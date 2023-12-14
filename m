Return-Path: <linux-pm+bounces-1160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC3813666
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581EF1C20C63
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8160B8E;
	Thu, 14 Dec 2023 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrbA7uB/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C810F;
	Thu, 14 Dec 2023 08:37:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3364c9ba749so122101f8f.1;
        Thu, 14 Dec 2023 08:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702571821; x=1703176621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcCiI3TQ8gopQV9tnMaS9uQNfvMYnRZBR7pxWDWkr/8=;
        b=CrbA7uB/zi9PXh1Cyv+UaEFnSXoTL9tviw7zCnS26oDNVsebOmUF+G0vdqjCSIXSyC
         GNtPgEjz2lHlPkTonBXON/R80erQqh3g3lGzYbK26gSf2lH+GlkexYdD0WdaSeWdkKZd
         tz+O8MSaV92fl0OPO6fewU1iRTsqiYpMKqIesVxDju+T3q7E0LWHoMeE5lhNDRfbapy1
         IcIJOf8lKVtFuFGC7RmD74xG68SOJJkld2U7/Xd4+aPaThmnglCbnHTSXQSp8fcaokix
         QidXc4PeohzwPihXqfKcHY5uhvdvJMDsitKb4wJqRdn68LlP+L/ilPFu0C4ZHSKEecLg
         uW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571821; x=1703176621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcCiI3TQ8gopQV9tnMaS9uQNfvMYnRZBR7pxWDWkr/8=;
        b=JBDYR5R9f+jPTW0hjnZ5K21tDB85hi2QvnBcj5rEJFBeFtKZVCYnu9psr2NQxnhVTf
         9HiwXjXnFm0p6Ou70AGolU6RYkq+k0ZDH9hfQ6RN2oLuHjOluOdLkbm3MRmV5JesZxtj
         SPzr1fLl3abJRO/MFhmw3+nzesSV0bOzE5uOLkw4KDQeyXiR31FQFZaaprs0ouv4Jt0P
         DfYBB8i5rFeLc0MHtnmkVfTAGZ+PfV/if87WjYm+XVh3JXkdhaALLw5sM8KD5xrKScsC
         BwWBqIGDhZAvUc6QvI3jhud/jW4uAGqphlyXFveeZXpyGBdU/q4gu5cu+nv25jOmD81O
         x6cQ==
X-Gm-Message-State: AOJu0YxAhfEBe3XklROKWVfM4gENm8hyIEQ8aSG9lK7BHk27wp+ICBJ1
	RC3SkudTj6N0BvBPvOFgG7Y=
X-Google-Smtp-Source: AGHT+IF7IW71yfGUG4q0bOw/8YVkeH6lRc27QSTBg3suiLoVsXi8oVaj5T3bf+/+et/gNTlQqLCjlA==
X-Received: by 2002:a05:600c:1819:b0:40c:3630:264b with SMTP id n25-20020a05600c181900b0040c3630264bmr1912250wmp.249.1702571820876;
        Thu, 14 Dec 2023 08:37:00 -0800 (PST)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm25400470wms.7.2023.12.14.08.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:37:00 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, Conor Dooley <conor@kernel.org>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH 1/5] riscv: dts: allwinner: Update opp table to allow CPU
 frequency scaling
Date: Thu, 14 Dec 2023 17:36:59 +0100
Message-ID: <2177637.Mh6RI2rZIc@archlinux>
In-Reply-To: <20231214-junkyard-corset-d35b01bad69f@spud>
References:
 <20231214103342.30775-1-fusibrandon13@gmail.com>
 <20231214111446.camz2krqanaieybh@vireshk-i7>
 <20231214-junkyard-corset-d35b01bad69f@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 14, 2023 2:47:14 PM CET Conor Dooley wrote:
> On Thu, Dec 14, 2023 at 04:44:46PM +0530, Viresh Kumar wrote:
> > On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> > > Two OPPs are currently defined for the D1/D1s; one at 408MHz and
> > > another at 1.08GHz. Switching between these can be done with the
> > > "sun50i-cpufreq-nvmem" driver. This patch populates the opp table
> > > appropriately, with inspiration from
> > > https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi
> > > 
> > > The supply voltages are PWM-controlled, but support for that IP
> > > is still in the works. So stick to a fixed 0.9V vdd-cpu supply,
> > > which seems to be the default on most D1 boards.
> > > 
> > > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > ---
> > >  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 18 +++++++++++++++---
> > >  1 file changed, 15 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > index 64c3c2e6c..e211fe4c7 100644
> > > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > @@ -39,16 +39,22 @@ cpu0_intc: interrupt-controller {
> > >  	};
> > >  
> > >  	opp_table_cpu: opp-table-cpu {
> > > -		compatible = "operating-points-v2";
> > > +		compatible = "allwinner,sun20i-d1-operating-points",
> > 
> > I don't think you should add a new compatible for every SoC that needs
> > to be supported by a DT bindings and cpufreq driver. Maybe you should
> > just reuse "allwinner,sun50i-h6-operating-points" and it will work
> > fine for you ?
> > 
> > Rob ?
> 
> The driver can definitely just reuse sun50i-h6, but the binding and
> devicetree should have a soc-specific compatible for the sun20i-d1.

Correct. This is to avoid later regrets if it turns out there are some slight
differences or additional functionality.

Best regards,
Jernej

> 
> That said, the compatible does need to be documented, there's a
> dt-bindings patch missing from this series.
> 
> Cheers,
> Conor.





