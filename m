Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9EA373098
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 21:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhEDTRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhEDTRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 15:17:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DA4C061574
        for <linux-pm@vger.kernel.org>; Tue,  4 May 2021 12:16:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m11so8988694pfc.11
        for <linux-pm@vger.kernel.org>; Tue, 04 May 2021 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rVaoA5kN9/YA+dlLhfwPSk3NfebR3WIgBEimIrB5M90=;
        b=f91FQNgUFD8vQnaaFNLLy2tlsQJ59H2CR5ohNwKUU04xp1VF4IIbYcKm1TU1tvQfYF
         ATC7f2HV1LY8c6UxCNQYe76DH4BwWykkcE8x5X7K7NEVTDbJpodGoHX/cULy4N7/zDS+
         LOpHLxaDz8wLiR+Y2RI80o834JSHh0q64Ql0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVaoA5kN9/YA+dlLhfwPSk3NfebR3WIgBEimIrB5M90=;
        b=iAZaaxyDlYT8vEgGVS7xrus2hfvb+SkHNyJVqsc8y/PSXuuGWMiMziCz99EmQNbJyj
         ZCMVXyud0wBqVnl9RkVEqmZAKKWORSw6PhytK2LOA1rRYmxwC2OxTVH3Aazh4SCk+Jf+
         tm04T/MBsw0i+/rqkDFN+Nb6FyhJiiKqXA/daozKT0opc5IY/rykl5cBD4xiQXB78VRm
         9Zr0CBhNiCfD2StFdIndhCbolCoxLmLbySSKizIsXp9s/JMlT8kUJ8zAmgJAEgzusFZ1
         kHCF+0wfLkUHFSTkvpLBUjhG/teJQ94Xc9v6NlE/hJAyFmFCMOYZHIY7evOcaBuyGlVc
         m6ow==
X-Gm-Message-State: AOAM533DYzLE635KYLg1xiz2azuS8G3r+7g/RD22Q+pAOXKr5ayMQxMJ
        3TN7Y6/B8Bv/oNnEADWS39qiSA==
X-Google-Smtp-Source: ABdhPJwKbZFIR6zgWDtGZDFHTspmIR1D1rCFO8lIMwXl/Fi+eINfevYxEbFjCQBxxzTO7WcM21yFuQ==
X-Received: by 2002:a63:580b:: with SMTP id m11mr24907711pgb.448.1620155795877;
        Tue, 04 May 2021 12:16:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4c2f:1f84:af45:6245])
        by smtp.gmail.com with UTF8SMTPSA id u12sm5108385pji.45.2021.05.04.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 12:16:35 -0700 (PDT)
Date:   Tue, 4 May 2021 12:16:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, swboyd@chromium.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Message-ID: <YJGdkVeJDQObFlNh@google.com>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <20210504144215.svmrmmsy4jtoixzv@bogus>
 <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 04, 2021 at 11:55:10PM +0530, Sibi Sankar wrote:
> Hey Sudeep,
> 
> Thanks for the review!
> 
> On 2021-05-04 20:12, Sudeep Holla wrote:
> > On Fri, Apr 30, 2021 at 07:58:21PM +0530, Sibi Sankar wrote:
> > > Add OPP tables required to scale DDR/L3 per freq-domain on SC7280
> > > SoCs.
> > > 
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 135
> > > +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 135 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index 0bb835aeae33..90220cecb368 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > 
> > 
> > [...]
> > 
> > > @@ -248,6 +273,116 @@
> > >  		};
> > >  	};
> > > 
> > > +	cpu0_opp_table: cpu0_opp_table {
> > > +		compatible = "operating-points-v2";
> > > +		opp-shared;
> > > +
> > > +		cpu0_opp1: opp-300000000 {
> > > +			opp-hz = /bits/ 64 <300000000>;
> > > +			opp-peak-kBps = <800000 9600000>;
> > > +		};
> > > +
> > > +		cpu0_opp2: opp-691200000 {
> > > +			opp-hz = /bits/ 64 <691200000>;
> > > +			opp-peak-kBps = <800000 17817600>;
> > > +		};
> > > +
> > > +		cpu0_opp3: opp-806400000 {
> > > +			opp-hz = /bits/ 64 <806400000>;
> > > +			opp-peak-kBps = <800000 20889600>;
> > > +		};
> > > +
> > > +		cpu0_opp4: opp-940800000 {
> > > +			opp-hz = /bits/ 64 <940800000>;
> > > +			opp-peak-kBps = <1804000 24576000>;
> > > +		};
> > > +
> > > +		cpu0_opp5: opp-1152000000 {
> > > +			opp-hz = /bits/ 64 <1152000000>;
> > > +			opp-peak-kBps = <2188000 27033600>;
> > > +		};
> > > +
> > > +		cpu0_opp6: opp-1324800000 {
> > > +			opp-hz = /bits/ 64 <1324800000>;
> > > +			opp-peak-kBps = <2188000 33792000>;
> > > +		};
> > > +
> > > +		cpu0_opp7: opp-1516800000 {
> > > +			opp-hz = /bits/ 64 <1516800000>;
> > > +			opp-peak-kBps = <3072000 38092800>;
> > > +		};
> > > +
> > > +		cpu0_opp8: opp-1651200000 {
> > > +			opp-hz = /bits/ 64 <1651200000>;
> > > +			opp-peak-kBps = <3072000 41779200>;
> > > +		};
> > > +
> > > +		cpu0_opp9: opp-1804800000 {
> > > +			opp-hz = /bits/ 64 <1804800000>;
> > > +			opp-peak-kBps = <4068000 48537600>;
> > > +		};
> > > +
> > > +		cpu0_opp10: opp-1958400000 {
> > > +			opp-hz = /bits/ 64 <1958400000>;
> > > +			opp-peak-kBps = <4068000 48537600>;
> > > +		};
> > > +	};
> > > +
> > 
> > NACK, this breaks if there is a mismatch from what is read from the
> > hardware
> > and what is presented in this table above. Either add it from the some
> > bootloader or other boot code to this table reading from the
> > hardware/firmware
> > or find a way to link them without this.
> > 
> > Sorry I had warned long back about this when such links were discussed
> > as
> > part of interconnect binding.
> 
> Not sure why this warrants a NACK,
> as this was consensus for mapping
> cpu freq to DDR/L3 bandwidth votes.
> (We use the same solution on SDM845
> and SC7180). The opp tables are
> optional and when specified puts in
> votes for DDR/L3. In the future the
> table can be safely dropped when more
> useful devfreq governors are upstreamed.
> 
> cpufreq: qcom: Don't add frequencies without an OPP
> 
> I guess your main concern for breakage
> is ^^ commit? The original design is
> to list a super set of frequencies
> supported by all variants of the SoC
> along with the required DDR/L3 bandwidth
> values. When we run into non-documented
> frequency we just wouldn't put in bw
> votes for it which should be fine since
> the entire opp_table is optional. If
> this is the reason for the NACK I can
> try get it reverted with Matthias's ack.

Couldn't omitting the vote result in inconsistent performance at OPPs
w/o DT entry?

Let's assume the Soc has (at least) the following OPPs:

  cpu0_opp1: opp-300000000 {
           opp-hz = /bits/ 64 <300000000>;
           opp-peak-kBps = <800000 9600000>;
  };

  cpu0_opp3: opp-806400000 {
          opp-hz = /bits/ 64 <806400000>;
          opp-peak-kBps = <800000 20889600>;
  };

  /* missing in the device tree */
  cpu0_opp4: opp-940800000 {
          opp-hz = /bits/ 64 <940800000>;
          opp-peak-kBps = <1804000 24576000>;
  };

  cpu0_opp5: opp-1152000000 {
          opp-hz = /bits/ 64 <1152000000>;
          opp-peak-kBps = <2188000 27033600>;
  };


When the CPU frequency changes from 1.152 GHz to 940.4 MHz the
bandwidth vote is omitted because the new OPP isn't listed in the
DT, the DDR/L3 bandwidth remains at the value for 1.152 GHz, which
is fine in terms of performance, but has a penalty in terms of power.

In case the CPU frequency changes from 806.4 MHz to 940.4 MHz the
bandwidth vote is also omitted, but now the DDR/L3 bandwith stays
at the value for 806.4 MHz, which could have a negative impact on
performance. The impact would be even larger if the switch happened
from a lower OPP, like OPP 1.
