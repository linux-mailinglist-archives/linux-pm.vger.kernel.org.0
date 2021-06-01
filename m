Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83D33972AC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhFALqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 07:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhFALqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 07:46:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310B8C06175F
        for <linux-pm@vger.kernel.org>; Tue,  1 Jun 2021 04:44:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e22so10460198pgv.10
        for <linux-pm@vger.kernel.org>; Tue, 01 Jun 2021 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zUuBlevDml1RsQmUcJ3i0Xl7Pbt1BMQJv/H4BpeTbs4=;
        b=wJB/xCUiFi4akZMhxo2B7DlgwZfFQIEYn4N/AW59AMcymGly3G9+wq3KBOcIh0jyEg
         jaw119dClX+VlreibdlDHU998M2zPLm4P3UkG4FYFoR7Gs6ZTxkdstOjQO81WEO3/66E
         D43hTf1Zv1DWu39wy8e+HIOPYxfcIKBr95dtcQIbxbkN40GSzZjVc+7djlK3PK+BNJTP
         yhgq9oRRkDTosR33WVGAzemSjkYhcQYvmZDm1oEBHqta/Jw5FjPebpxkHFTlxDAdbFx8
         Mjx5ms/A18kQyTzW3AJD2Y5d2D47s1chlk/iwX7Uz5+YcSbfiWSBSB7Qu+Hrs5dsnsDC
         tNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zUuBlevDml1RsQmUcJ3i0Xl7Pbt1BMQJv/H4BpeTbs4=;
        b=jh5/440ewnrwFZccbUIuEE0zryq9ymXRFvKwbQxyuvXD29Flac7Zt6yI3LPKsKlXKR
         qOlIRx0cjhtqXXSRWC9HQZPjFeZFDErHdUnmF+NmbO3Fy8T8kHRm5kJpPhtGb9V74ZrG
         5B9Cx3A58tMOVewNccWIO0SmXa0Tpi6zs1X5LayVpu4XuJYU9hwjlX2Th5FL/dRXxsc0
         aZSNDFvu37g3wPBLwJUYsrxl/55Nipk5nXaSRxHRt3SyHFY/kCk9Kz5vNd+2gQy5+KdF
         NVJRB5oGpH+mS/0UmOwpjlcypzskt0isGcILW+22QbRXlJ97MnpMQQ6yUdm9IwpS3Y9L
         i1Ow==
X-Gm-Message-State: AOAM530rB7UbRteRvZqHDqGGSD1OL7CkYgpgTe+Ui4qk7ZKFgWXbwjNK
        ouNO45zhvaB+gZFVtiUtk2RU+w==
X-Google-Smtp-Source: ABdhPJzGgQOKQeJuHCotgvJ/qS4B4/iYGR2HD+vCofFVAcj+a5E+3QEYwRq58t171wWXWNbFZ49CGw==
X-Received: by 2002:a63:5c4e:: with SMTP id n14mr27752883pgm.192.1622547868703;
        Tue, 01 Jun 2021 04:44:28 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id s123sm13088954pfb.78.2021.06.01.04.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:44:28 -0700 (PDT)
Date:   Tue, 1 Jun 2021 17:14:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce
 'assigned-performance-states' property
Message-ID: <20210601114426.3vhh2twocqx254b6@vireshk-i7>
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
 <YLYV3ov/iBffZMg4@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLYV3ov/iBffZMg4@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-06-21, 13:12, Stephan Gerhold wrote:
> > +    child4: consumer@12341000 {
> > +        compatible = "foo,consumer";
> > +        reg = <0x12341000 0x1000>;
> > +        power-domains = <&parent4>, <&parent5>;
> > +        assigned-performance-states = <0>, <256>;
> > +    };
> 
> Bjorn already asked this in v1 [1]:
> 
> > May I ask how this is different from saying something like:
> >
> > 	required-opps = <&??>, <&rpmpd_opp_svs>;
> 
> and maybe this was already discussed further elsewhere. But I think at
> the very least we need some clarification in the commit message + the
> binding documentation how your new property relates to the existing
> "required-opps" binding.
> 
> Because even if it might not be implemented at the moment,
> Documentation/devicetree/bindings/power/power_domain.txt actually also
> specifies "required-opps" for device nodes e.g. with the following example:
> 
> 	leaky-device0@12350000 {
> 		compatible = "foo,i-leak-current";
> 		reg = <0x12350000 0x1000>;
> 		power-domains = <&power 0>;
> 		required-opps = <&domain0_opp_0>;
> 	};
> 
> It looks like Viresh added that in commit e856f078bcf1
> ("OPP: Introduce "required-opp" property").
> 
> And in general I think it's a bit inconsistent that we usually refer to
> performance states with phandles into the OPP table, but the
> assigned-performance-states suddenly use "raw numbers".

I must have missed that discussion, sorry about that.

The required-opps property, when present in device's node directly, is about the
(default) OPPs to choose for that device's normal functioning as they may not do
DVFS.

Good point Stephan.

-- 
viresh
