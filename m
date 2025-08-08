Return-Path: <linux-pm+bounces-32064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F31B1E9D5
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 16:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC771C250CD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538C1624C5;
	Fri,  8 Aug 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="kyJqnXwX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93C1B7F4;
	Fri,  8 Aug 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661803; cv=none; b=YIiULVEMxeiVaJr4YJeiRl7Ivb+x7hGkS+Vbgw9N4M/+/jUs436HfLwoLFUcc7f64c+sXS/xQ47RMPY0M8lXe/TDRSASb8aJQ92aYj7Djhf0Bvx81KDR5sqUPqjMwmTQJFvf0Ap0R7Huq3E+LNAb+hoZuozUvC2VBCvti+10IWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661803; c=relaxed/simple;
	bh=QwyJWn1v3WAqphWgHvxIPI2oFVDIAeFdWM4Gnk/jbpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFXBIkw+uryb8RX64qU85ek5Cy98Y9VzTeO99+/i6Ri4blflvbda6jKd+OQFcpT9hcN3JK++7/Yf1onf5nDgcnpvWBC2K82lhV9aY/rhZbSZsggSQDG4hNGc/r5RCMmi2i6aAkkYOGvT/PeK78lBtfBV31ZJ13TvE1plKkflBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=kyJqnXwX; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 832FD3D8511E;
	Fri,  8 Aug 2025 10:03:20 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id UiYRFzM-k5nG; Fri,  8 Aug 2025 10:03:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AD3743D8511F;
	Fri,  8 Aug 2025 10:03:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AD3743D8511F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1754661799; bh=iGxSN543u6zBI2HpCOyAq8UQ3mK2B6N3dnkwlQ0/x54=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=kyJqnXwX/YgUnbw8wKN2P/80haewqhbsbZZvlkPIlsRvkErKhnKJLZSuMhk2qosTg
	 2YVazIXK3CAEtm6tsGf71CYOseFIYTtzwxzDeY2lnKx+3YuwgbNXpWsHVDvZSRRXPp
	 7UvDQEM81tkhIlOnRfFneaBHFo04fkMEUpXY0NPHl7PdwFbAzcRJvCFFGSHNi0SkR5
	 HM4F1R0UOX0x/7UYCaNq2EYfY85OlEW2gp0TsPtzsBKQS9Sf0sLhg++MzWETVToUel
	 LiHoa3DzJma1+gdvuWOL8z/vDI85zC/oNSFSjh4ft2Dqmn7DrGZKBkoK3BW7Z4vtk5
	 AbP6Tz33IUWdQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Rp1CR3m8GihI; Fri,  8 Aug 2025 10:03:19 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 524F03D8511E;
	Fri,  8 Aug 2025 10:03:19 -0400 (EDT)
Date: Fri, 8 Aug 2025 10:03:18 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/6] dt-bindings: mfd: add pf1550
Message-ID: <aJYDpp9Y6vLmzUfg@fedora>
References: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com>
 <20250716-pf1550-v9-1-502a647f04ef@savoirfairelinux.com>
 <gj565636v5qgohhf5usklfqydkc6lzifzhrbquoyawbwvhdlma@kajszdivkp2e>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gj565636v5qgohhf5usklfqydkc6lzifzhrbquoyawbwvhdlma@kajszdivkp2e>

On Fri, Aug 08, 2025 at 10:10:35AM +0000, Sean Nyekjaer wrote:
> Does it make sense to show that the driver support suspend to mem
> states? Like...
I don't see any reason not to. So, I can add that in the next version.
> 
> 
> 			sw1_reg: sw1 {
> 				regulator-name = "sw1";
> 				regulator-min-microvolt = <1325000>;
> 				regulator-max-microvolt = <1325000>;
> 				regulator-always-on;
> 
> 				regulator-state-mem {
> 					regulator-on-in-suspend;
> 					regulator-suspend-max-microvolt = <900000>;
> 					regulator-suspend-min-microvolt = <900000>;
> 				};
> 			};
> 
> 			sw2_reg: sw2 {
> 				regulator-name = "sw2";
> 				regulator-min-microvolt = <1350000>;
> 				regulator-max-microvolt = <1350000>;
> 				regulator-always-on;
> 
> 				regulator-state-mem {
> 					regulator-on-in-suspend;
> 				};
> 			};
> 
> 			sw3_reg: sw3 {
> 				regulator-name = "sw3";
> 				regulator-min-microvolt = <3300000>;
> 				regulator-max-microvolt = <3300000>;
> 				regulator-always-on;
> 
> 				regulator-state-mem {
> 					regulator-on-in-suspend;
> 				};
> 			};
> 
> 			vldo1_reg: ldo1 {
> 				regulator-name = "ldo1";
> 				regulator-min-microvolt = <2900000>;
> 				regulator-max-microvolt = <2900000>;
> 				regulator-always-on;
> 
> 				regulator-state-mem {
> 					regulator-off-in-suspend;
> 				};
> 			};
Will include these in the next version.

Thanks,
Sam

