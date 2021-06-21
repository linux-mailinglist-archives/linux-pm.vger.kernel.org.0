Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E433AE8A9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhFUMGR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 08:06:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:36278 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhFUMGO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 08:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624277028;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=c+nIPTLbwTwv3NgxdRJeapby6BUJ8czrRYkdGY5Q3eI=;
    b=q7OLoipFGcqxGrst+eo6N4qwdbA5vaODusqvon3o3OHTLL09QXjUHCcLhvA0yy1Eew
    q56bg7lRO3cDXNEYztxCRguWQPoNT6LdEQKVKG8ScREld7EuveH/yIPMBxbUhGczMvg+
    MyrH3ZqQZljesRMkxGqQ+6gv3J1yrlPEDSpxiKwvcBq1PhGmDR0crLppjzeFl1IKgFWC
    2v4H0XYYf/kGfZIR2jtx1ylW0sXQxoZj4fMeArRPMdRhM4imWtUsSzhONYisvLvCYrO9
    aKNv76QEU4q036duWmLmauYoqKqSX7Hq+VNKhBPuo9STjputQp4ZoXsXoCxPoUdQFAz/
    rx/w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j5IczAb4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5LC3lI14
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Jun 2021 14:03:47 +0200 (CEST)
Date:   Mon, 21 Jun 2021 14:03:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 2/3] soc: qcom: spm: Implement support for SAWv4.1,
 SDM630/660 L2 AVS
Message-ID: <YNCAIr3BGB1J+wpe@gerhold.net>
References: <20210618225620.623359-1-angelogioacchino.delregno@somainline.org>
 <20210618225620.623359-3-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618225620.623359-3-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 19, 2021 at 12:56:19AM +0200, AngeloGioacchino Del Regno wrote:
> Implement the support for SAW v4.1, used in at least MSM8998,
> SDM630, SDM660 and APQ variants and, while at it, also add the
> configuration for the SDM630/660 Silver and Gold cluster L2
> Adaptive Voltage Scaler: this is also one of the prerequisites
> to allow the OSM controller to perform DCVS.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/soc/qcom/spm.c | 28 +++++++++++++++++++++++++++-
>  include/soc/qcom/spm.h |  4 +++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> [...]
>  static const struct of_device_id spm_match_table[] = {
> +	{ .compatible = "qcom,sdm660-gold-saw2-v4.1-l2",
> +	  .data = &spm_reg_660_gold_l2 },
> +	{ .compatible = "qcom,sdm660-silver-saw2-v4.1-l2",
> +	  .data = &spm_reg_660_silver_l2 },

I think we need some dt-bindings patches for these? :)

Also, like I mentioned on v4 I still think a short comment in commit
message or file with the reason why you don't want the change qcom did
in [1] would be appropriate here. You can just use what you
already mentioned in your reply in v4 (the random lockups).

Because otherwise it's not obvious why someone else shouldn't "make this
consistent with qcom's values" sometime later and then suddenly you get
the random lockups again.

Thanks,
Stephan
