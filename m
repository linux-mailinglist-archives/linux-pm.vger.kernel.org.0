Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD82825A0
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgJCRdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 13:33:42 -0400
Received: from msg-2.mailo.com ([213.182.54.12]:55670 "EHLO msg-2.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgJCRdm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 13:33:42 -0400
X-Greylist: delayed 11171 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2020 13:33:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1601735247; bh=imNu7MHThjAESrJNpmhOyRli59QkLGoI0kFTAxDCsF8=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=dkMhJ5QchIXG+Hy8U/wfRx6/oubjDIaRXvmWAAWFfawB6K0AxUrgCTw18dL4djFnk
         ei6Jzj7BArFFCk2gZr7J3EdNa6kB46xr5jFll/hep3ZvnprKjz/A0HHTObsxf8PW9q
         UHpjoKrDY4nwba5Q+7DYMhii3mSSOvc3yb8+q8Ks=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sat,  3 Oct 2020 16:27:27 +0200 (CEST)
X-EA-Auth: chZqOqSjMGhpYYrQYEHoviLKXI/U1P1qJspKX9NxQLD9OuH6MudHEBb/csrmzqyfTT+/ZA0dRFaEiu+ioS21gGuiUmLOx5GEte2jXfSbrto=
Message-ID: <104955668ed768682adf1757e79022117460d268.camel@mailoo.org>
Subject: Re: [PATCH 1/5] interconnect: qcom: Consolidate interconnect RPM
 support
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Jun Nie <jun.nie@linaro.org>, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Cc:     shawn.guo@linaro.org
Date:   Sat, 03 Oct 2020 16:27:25 +0200
In-Reply-To: <20200930081645.3434-2-jun.nie@linaro.org>
References: <20200930081645.3434-1-jun.nie@linaro.org>
         <20200930081645.3434-2-jun.nie@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le mercredi 30 septembre 2020 =C3=A0 16:16 +0800, Jun Nie a =C3=A9crit :
> Add RPM based interconnect driver implements the set and aggregate
> functionalities that translates bandwidth requests into RPM messages.
> These modules provide a common set of functionalities for all
> Qualcomm RPM based interconnect providers and should help reduce code
> duplication when adding new providers.
>=20
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/interconnect/qcom/Makefile  |   3 +-
>  drivers/interconnect/qcom/icc-rpm.c | 194 ++++++++++++++++++++++
>  drivers/interconnect/qcom/icc-rpm.h |  73 +++++++++
>  drivers/interconnect/qcom/msm8916.c | 241 ++--------------------------
>  4 files changed, 279 insertions(+), 232 deletions(-)
>  create mode 100644 drivers/interconnect/qcom/icc-rpm.c
>  create mode 100644 drivers/interconnect/qcom/icc-rpm.h
>=20
> diff --git a/drivers/interconnect/qcom/Makefile
> b/drivers/interconnect/qcom/Makefile
> index 1702ece67dc5..f5e803489de0 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -9,7 +9,7 @@ icc-rpmh-obj				:=3D icc-rpmh.o
>  qnoc-sc7180-objs			:=3D sc7180.o
>  qnoc-sdm845-objs			:=3D sdm845.o
>  qnoc-sm8150-objs			:=3D sm8150.o
> -icc-smd-rpm-objs			:=3D smd-rpm.o
> +icc-smd-rpm-objs			:=3D smd-rpm.o icc-rpm.o
> =20
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) +=3D icc-bcm-voter.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) +=3D qnoc-msm8916.o
> @@ -21,3 +21,4 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) +=3D qnoc-sc7180=
.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) +=3D qnoc-sdm845.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D qnoc-sm8150.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) +=3D icc-smd-rpm.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) +=3D icc-smd-rpm.o

Duplicate ?

Thanks for msm8939 work, please Cc: me on any related patch :-)





