Return-Path: <linux-pm+bounces-38201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C8C6CD36
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 06:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7A394E6C98
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64C258EE0;
	Wed, 19 Nov 2025 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMQU49wI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC09156F45
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531356; cv=none; b=fRfDRWJdvryEi5vR3WSm2Qg0Tcd36bv0UEi+7x+X6/m12+b2AHFAK5IDhGyaFt3vAWy/YyofJZ0NBuFN6ab5+Gg5LS1iK4mt8X8XzV5K36CEo/4U1yP0Tl3ry54e3U+sTCmHMRwRyS3VBba4r/iLHMDwzB/wOtzdRk0I13DNRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531356; c=relaxed/simple;
	bh=UT+oK4HjoZ6Qe9gAfL7qbeZffPaQLIagEqMxVONPoAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O95fSdxxE99BUAL5GzSVb/6tmcdRujsm+BW6EBXFWAcV70xL9aHUlFx5GECVUwq98HjPwUsl+dMpC9HT5Df3tQH0RRtY0BUgGc/lvuJ8p77+aEFsllmE4G0DAY2OEEGf8NdFoAUpjQ1qsQj26ASANB54SHEcs9GiYTXMZwAGEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMQU49wI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e982506fso77167035ad.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 21:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763531354; x=1764136154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0+Vr6x/hD2XVE7vVSWrfWAau9JVLWZCdzaXwsWMD+A=;
        b=gMQU49wIC+638NiKTygSiHQPP85oy4i4Ao/foLCNexIX6Uzf/Ye2EA0icau3HxiI9F
         Dzp/nbCuY2vcjb9s52bUVIB004ZacizFhWbgFKknIkR/yT7Q0g0wsjlf/YN2ULLZB+x7
         eq2gwKpP8tUeU8X2DituXFRCmN2prSN3Stnaa8Kh8aj4gLx2pcWOmBsQYQKBY15roO0d
         kFHqKEarhksiFBbyF/vWEOyWJHoIyht/KTCyKb90jOHTyaTVLiVXS8pwrM1rbpB4lCu4
         SnfMpVt6bkI3fukt7stIZ4NEcuoTRdlW+8eAdBqpbEyhXqFdTcLTFBpflRnvVThhNNMc
         xCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763531354; x=1764136154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0+Vr6x/hD2XVE7vVSWrfWAau9JVLWZCdzaXwsWMD+A=;
        b=p73RN4B2xxhMFPKy2642DIcEfiBlhqG81wM2RrWCTv+0j8A/7IJgQ8BIVp3b5ClfCd
         dZjE+FzPWexW/GtgmFfrqVfo2kquhMgmB10cqzCYkDsXyDEv00Soxun+qh36uMarAQv/
         gWUSZKrr5snNwfOKJa+WorV2O0w9Ls1U0/awSWiUTXCiPQ5iODXNC2mJBPgNTOa3acIC
         AIEF8+QZSFHfSZHYyj0JT5H+xzbUYBcpx6ybaTI05p3erghmi49u5y6BZevMMU+kN4uX
         zm7AOhrU+ZKTL4r2N70gbEJo7GWS7BHHILe/YNpCj18ex9HutXoY5vhtYxJUebahK/Bi
         i90A==
X-Forwarded-Encrypted: i=1; AJvYcCWAfjC5F1hb5Jx/lxGZNZhKbDZ7+TA0+kE+bcI8n1MnrV9TQskfagrlH3a2sXOdr0iZaSKg1ZdxaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBZIAmkogXMw/8BLooeCVvjvNSBuIZNWsy6v0laps3503guc+
	KxyrHTWwLusWQuaiJHC/y2WZsl6FvZvdtT1Sa+A6w0fKH+dYrNJa2taBBjG3Q+yOOLQ=
X-Gm-Gg: ASbGncthTymQ7LEmR0M6vg8Mrq/bxiQJBiYNsnds/j0rR4vY/16WCXDntwWB4NJINz4
	58d1hnpzKFbCwXGJTIyIY+cY+HfUPFPnJsKq36LzOOXQYNE3uzzlkO5xLgHnyPPc9aJQrmhcS3s
	TQs805KVAP+eA6zp9VKuPPu6o6mBD+MDPQYww+mZPFGPmJ76haClLiV3i7Bi9GSsysQVpY7QzOP
	Fn9hyYhewy+sQOyNPLL91UYOn20mPm70KQeDxd32wOxgoLF3Nz1iAtFyvmhYZW+3yAIEcWmzsPm
	gw8011YJqKNrHz5tXpwD4zK1tX+HM+FRR5CmAKJkBTQTYhtBizievo7YscJ/MwrzVv7+Joi10+j
	bQ+NPwsV59SBpbHkTS+w2VeXBgwD7HGFtPWfllOkIhGrlVdVadEaiBgbIaiLTxTkugwcu5VO6Vw
	C55Rw5RjhxWOzmpcuS4H9Kdw==
X-Google-Smtp-Source: AGHT+IF83DkAlKom8H7yCIpqPkymM7Zq3lrKGS/FtMNUWxAOSoRjHEAR51MHxjq/T/AP7dmUpoqC8w==
X-Received: by 2002:a17:902:fc8e:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2986a6d6612mr219651425ad.14.1763531353657;
        Tue, 18 Nov 2025 21:49:13 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b10b4sm192307065ad.70.2025.11.18.21.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 21:49:13 -0800 (PST)
Date: Wed, 19 Nov 2025 11:19:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, vireshk@kernel.org, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: Queries on required-opps on calling dev_pm_opp_set_opp()
Message-ID: <o67y2z47husak2ic3adb2w4kxst5vfdr3vdk3wifhbpyao7hew@jj5qerm3qxor>
References: <8e542a9d-132d-45c3-b17f-1dcea4bdf337@oss.qualcomm.com>
 <7paqqdkxfxd3hz76o7o4q7pkmc27czqtn3smffpkwoha7bncdq@w7ik7v3c5uwk>
 <b3e9403e-6194-448d-a361-45c645a2ab2b@oss.qualcomm.com>
 <kaxxdh2xt4hghwn23qzle5wx2ltdzq7eyp7rtyvbsgffjvowv6@hgphk72idpbz>
 <621fbd17-99c6-4669-9d7f-4c1c42270dcd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621fbd17-99c6-4669-9d7f-4c1c42270dcd@oss.qualcomm.com>

On 18-11-25, 21:22, Krishna Chaitanya Chundru wrote:
> Are you suggesting to retrieve the required clock from the phy node and vote
> from the controller
> driver? If that is case it will not generic as some targets have different
> name for refgen clock in
> phy node. And this will be like a hack to do it from controller driver.
> 
> If this is not the one you suggested can you give me some more details on to
> change the frequency.

This is your controller node, right ?

                pcie0: pcie@1c00000 {
                        compatible = "qcom,pcie-sm8450-pcie0";

                        clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
                                 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
                                 <&pcie0_phy>,                          // Already has phy as a clk
                                 <&rpmhcc RPMH_CXO_CLK>,
                                 <&gcc GCC_PCIE_0_AUX_CLK>,
                                 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
                                 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
                                 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
                                 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
                                 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
                                 <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
                                 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
                        clock-names = "pipe",
                                      "pipe_mux",
                                      "phy_pipe",
                                      "ref",
                                      "aux",
                                      "cfg",
                                      "bus_master",
                                      "bus_slave",
                                      "slave_q2a",
                                      "ddrss_sf_tbu",
                                      "aggre0",
                                      "aggre1";

                        pcie0_opp_table: opp-table {
                                compatible = "operating-points-v2";

                                /* GEN 1 x1 */
                                opp-2500000 {
                                        opp-hz = /bits/ 64 <2500000>;
                                        required-opps = <&rpmhpd_opp_low_svs>;
                                        opp-peak-kBps = <250000 1>;
                                };

Can't we have two values in opp-hz here and configure phy's clk directly with
the current code only ?

-- 
viresh

