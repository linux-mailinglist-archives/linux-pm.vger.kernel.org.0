Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33D12E080
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jan 2020 22:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgAAVJ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jan 2020 16:09:57 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39174 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgAAVJ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jan 2020 16:09:56 -0500
Received: by mail-vs1-f66.google.com with SMTP id y125so13873056vsb.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Jan 2020 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aYDieUhitExXeI2UbuqM8SZ9CPVyMnqW1hv5zVbmms=;
        b=Z+zRHF3hQc9FsVfMFKoaiIBA+STwwOyf24A1lFk/D3IOqm9PPKmqGNBL8pbnrZjOUQ
         0I8jZZQLSB/7tfVHqhM84XnesVWxta55/bs96dHKUuaVYgMFSnypQC9At1ce3FRyPs9m
         W04f5Uklx6bpaeKRqshGUpv9VevDM4V3ffngFPmqH1vQhJPyto7wR96KNebbpfdBaM/a
         KJ7K8CPwicRM/clHtzsJOLHd2G83YLkQ2cVx3OakOWyhW9XveCTC6IURroHVijOBIfnS
         t0nVZ+OPIcgqlyIwmvQ4VUiJuoCJgyelg483rhtRTBCx0K55cYqyMHMIDuzkSpndaLhS
         BxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aYDieUhitExXeI2UbuqM8SZ9CPVyMnqW1hv5zVbmms=;
        b=Dk/+2hiUDaZTDjPENCZHODNakj9nR5lbvl49cIWxYSJWwmdZ0BE+gPihSpAf1zCmOO
         6KL+3tvQf+xgYuW+rV/zz5Hn5QJZva2+HVPdZnuPzFFNTSxsgpMwfrDMR6BQd5Ruokze
         c9kaMxiMfdFWWDEMQBEfsNp4EuSNUOdy3S1v5FlvFaC+rqxiF7ShIrirM238oJwx5wyT
         w2cYS682NvZlWP1eJFaQ1VgVh6C+B3Ain8h+JJmcHDiSN72mFh9lZwiSueEyCEw4vvj4
         mSbTAIBXROH9m27skIBl3dCIJ3dDSP59DGI1e3uUEHCYLemIuybVsueqhel+9DD4QdbS
         lAZA==
X-Gm-Message-State: APjAAAXYTF+VozlleMpmgGsb0egrgKpsL88+mLJTY2pr4mDw7+Wy9vgi
        OKditfH05+3otwwdcvi0cD97ZpBFGbkFNoXBF3WpmQ==
X-Google-Smtp-Source: APXvYqzT34L82mfpZd8EVpKQyCTFgNghbtJD3CR8DGdmxgH/UaurAPsacBqWgZNDQRJVVZlbvU6Whby/xYgscdh8s9o=
X-Received: by 2002:a67:d506:: with SMTP id l6mr44993831vsj.9.1577912995404;
 Wed, 01 Jan 2020 13:09:55 -0800 (PST)
MIME-Version: 1.0
References: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org> <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
In-Reply-To: <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 2 Jan 2020 02:39:44 +0530
Message-ID: <CAHLCerOvBnN0DsvFC8PFhw0ZC0+Qh-Qx95GEtbcWj=QoeM6NuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add configuration for
 sc7180 in yaml
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sanm@codeaurora.org,
        sivaa@codeaurora.org, manafm@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 23, 2019 at 6:46 PM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index eef13b9..c0ed030 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -38,6 +38,7 @@ properties:
>            - enum:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
> +              - qcom,sc7180-tsens
>                - qcom,sdm845-tsens
>            - const: qcom,tsens-v2
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
