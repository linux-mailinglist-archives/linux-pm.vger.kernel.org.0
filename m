Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684D86F4E9
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2019 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfGUTLq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jul 2019 15:11:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40190 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfGUTLq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jul 2019 15:11:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so16566481pgj.7
        for <linux-pm@vger.kernel.org>; Sun, 21 Jul 2019 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mmeWQsmDiPaK9d82z6VLfilyAyZg9OaXDMwYxakvAF4=;
        b=M2T/jKitt/ndj61hrkrzKLpQVRLZCq5yD+LHcZuZd/cHePE+rJBRBABvEx0q5PUQa8
         MTj0a/Gj5PvPl+yccsBxzayr6uHV6cTmshksC35R9/mPRnr5ASTlaSTpNWOQFtm24pkL
         mIXgtGMCNFmdMRVMBgJZlSHN9Hv1NKUX5YLNSjRHPZriU9dvLwB8wzJLzHo8mluATQJm
         1obxsTTAu3J8mMMFx7Iww7xA6HScxVxFNDw9KY1xNC07QtSS/TJT8ubWGHcgM+aFbJJM
         wKLLGIiBS63wD10eXycVG1jfFT5sw8HqvTtOSRLmWfQ+l+dBTYpcryy8Z80yDBLYCNJz
         KrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mmeWQsmDiPaK9d82z6VLfilyAyZg9OaXDMwYxakvAF4=;
        b=YT0cRjE8B5VP9H8ls52ct0hNH/Upnnkp4X+uzHTuKSvf+cym9A3idqOgXiR1ybWKDC
         uIirdsLTC2UuRc0/g2+1CUtkch5vCmUzRFtmEn7aTAgu+M83oqI3ku+Ebafb5Rs+29oc
         i9OWvEyr6DA+bwrtK5yPF/oqz7HTNtIyFx1v8yEIT3QLzuoNQGnDALuwtPKdVCcJcVAc
         Y78yyt05X73YhafiJc0Zok9CXOjSuwDD3mBfolcYcSdHxuBTP0zU/qNBC7YVvwnD/1dg
         Ze4OHqlC9zHX0VDysBwESlQ8heeDVHuKpkN5N66678u+CraprzOYLwBIUn+l2lo6bJOc
         SHdg==
X-Gm-Message-State: APjAAAVa0qgqBIsfrgy5hxWF48/NvkSZsS67x5HQeaAsNuVtMNAbx3bk
        N3BlwLAypk/CN8e2a6/LWeoZMA==
X-Google-Smtp-Source: APXvYqym+3nEqETS5wgsiUH/zTRbb9cNoEiTS+4Gh807QNShl0JCzM7CgRP8w5qWgHfscQ4yIxc+dw==
X-Received: by 2002:a17:90a:8688:: with SMTP id p8mr73835132pjn.57.1563736305446;
        Sun, 21 Jul 2019 12:11:45 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c69sm45113398pje.6.2019.07.21.12.11.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 12:11:44 -0700 (PDT)
Date:   Sun, 21 Jul 2019 12:13:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     georgi.djakov@linaro.org, robh+dt@kernel.org, evgreen@google.com,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Redefine interconnect provider
 DT nodes
Message-ID: <20190721191305.GI7234@tuxbook-pro>
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
 <1563568344-1274-3-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563568344-1274-3-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 19 Jul 13:32 PDT 2019, David Dai wrote:

> Add the DT nodes for each of the Network-On-Chip interconnect
> buses found on SDM845 based platform and redefine the rsc_hlos
> child node as a bcm-voter device to better represent the hardware.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e7d78bc..204222e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -610,6 +610,62 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		aggre1_noc: interconnect@16e0000 {
> +			compatible = "qcom,sdm845-aggre1_noc";
> +			reg = <0 0x16e0000 0 0xd080>;

Please pad the address to 8 digits and keep nodes sorted by address.

> +			#interconnect-cells = <1>;
> +			qcom,bcm-voter = <&apps_bcm_voter>;
> +		};
> +
> +		aggre2_noc: interconnect@1700000 {
> +			compatible = "qcom,sdm845-aggre2_noc";
> +			reg = <0 0x1700000 0 0x3b100>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voter = <&apps_bcm_voter>;
> +		};
> +
> +		config_noc: interconnect@1500000 {
> +			compatible = "qcom,sdm845-config_noc";
> +			reg = <0 0x1500000 0 0x5080>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voter = <&apps_bcm_voter>;
> +		};
[..]
>  		qfprom@784000 {
>  			compatible = "qcom,qfprom";
>  			reg = <0 0x00784000 0 0x8ff>;
> @@ -2801,9 +2857,8 @@
>  				};
>  			};
>  
> -			rsc_hlos: interconnect {
> -				compatible = "qcom,sdm845-rsc-hlos";
> -				#interconnect-cells = <1>;
> +			apps_bcm_voter: bcm_voter {

No '_' in node names, so bcm-voter.

Apart from this nits this looks good.

Regards,
Bjorn

> +				compatible = "qcom,sdm845-bcm-voter";
>  			};
>  		};
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
