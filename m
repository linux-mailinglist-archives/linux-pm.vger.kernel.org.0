Return-Path: <linux-pm+bounces-32510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E9B29D07
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84C37A140E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C881830DEC8;
	Mon, 18 Aug 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYmUCQIp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D03307499
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507765; cv=none; b=QFZEpFQdG3uJ/qFoP2Ww5KBimpckmKMs640Qa/QQKaqDZZ9KkG19s8OzhGSZzOSuEIqmQ2XCvJGilPUdACU92LNP+5vnFhwiKLnf0VfISfrQ1ij4+oxW7uHWFC8ZuFYKnWCVBU3x77NZYvXNYEYhdW/WeToEch0JEDsVOj4CDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507765; c=relaxed/simple;
	bh=KHB43Z17LrATDP+I+UcK8mr27MT522jgBABjSbmHMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWvXebWmy3u/1TeTSVP7XNklg3UYJKkMtOFKhapcm3NscRyfoKxhK6TMwwk6u7WgRPbhPV07RLJ8+1k59QJ6J2Ik5+kkQ6KpCSihJbGmhLatEHTRimDqnK46sVWgQHsz3dOaFPIr78u2+OswaGF1XaYd4RZPQe7YXwi/rYyCSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NYmUCQIp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244582738b5so29731445ad.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507763; x=1756112563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tw7dbgkD+zT5jAWthzRKn29Iz3U2WQf9p2WltyhBPN4=;
        b=NYmUCQIpI1imdGHzDkPC0xQkhWmc31Ix6vyTpNj5GGjgyKNOKWTHw0OdQ8yoEsIwU8
         bUnp0FFdKY7l6GYnQBdpOan/cFWgG14FPa4FxxyWgDxcknsg6czcPmJy+F0hiI5qxy5s
         p7+lp0xk8ekGyObhMKPcZkiVpxk61j64M+r6UshcqVE7X9Tu2it71NK8WJ4/6Dre+zFG
         O8wVcoIlRaY4eBRyfj2GClven61oBWxPQV+CS2iK/vp/57MPiEky574pRf6+oWucN/D8
         pE0Tpl+/9hO5jotUa2cDQIYpOtwuJF+sp8e9n4Vqq6eiaBcnc3FpPcMi2U/hT6swDifK
         vySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507763; x=1756112563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw7dbgkD+zT5jAWthzRKn29Iz3U2WQf9p2WltyhBPN4=;
        b=Bd9tQhH7asEY5eQEvjMjX3+WoODWi3jrAFH3/6cGHmtrcGMvzrJuxsZ8bM1tgoPy4T
         zcbvasvd/YUygT3XzMlV9mn28DFZ6POANyAitg4rJsWeNFX7d4/36VGrCjxJq8dpcDqc
         QNp0/Oyz9GAwAKyjim0ZP5yDS1jqe/ISyw78ovCbmls0uiWIi3/ZKYBCJvci+VD4eDSA
         VY6N+WuBzlvuq4UOCow0uFMB/UBW0bavhOCyA1M+bS45gb55sqk/6s/12IAv0tAqOIRC
         1vgqPlHtxhMs8S2dEtRFSyS1WCPAu3uBJu3gxW44N6keonpgXvWL9X2HEni7o40znD/7
         1hMg==
X-Forwarded-Encrypted: i=1; AJvYcCV8mNTcP0sP4VvSgkMc5OizlBmQNl1k3qegEUN6IVkNZDOBlguEjfreZLalD44cW4zX0fb/eGJ+kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJKFtn3GRg8rYI4ERBjC5NcVfwepmyXVKLJU9OSgH9GcDmVjL
	gsNpU7Xfg51BBI8F4vZ9YNuaNoTMBn5ieUDoxYp6dSD+HmilFhaUxrK68jjXwVhhPr4=
X-Gm-Gg: ASbGncssMx/l2UYzn1wESOn8CBaN7MDTD9/lsTNFBeWNvtWAwfhVP36uzMkpAHsG+i6
	lRjYJuurq74RDYErA+yU6QQ9cglXGxcDpXXqg79XdSF5wMaI0kTGxmex7UT0uFUratI4QIYTw2U
	3TZHDVpMlfJhoJydqNxfLA92oqoCCtAxPBL0ZuPB670Dz32y/k+S+3YzrYrLQLNBNrENVJ6a5QD
	XqbdylsEzS+5X5JWqcgpayqnVh1Tkq96hFBzi2/yQvw4UcLWQHLttnKDMTTZkfQE8JeJxhp3o3P
	Q4puGW8LF5IB1f0njvbarqvYiz1FSfu3aY9XQtYr7DkpYCOF1bGiz9iMpT+rvb/Evpr9k+J7XZm
	YJZew31G9IKNOGv6K1T0FHA2q
X-Google-Smtp-Source: AGHT+IE49BY+QEUKqeX/ukisuqIYp2KG3N61jubdd/2kSq1yDYk+d5vzKqRZTTbGf4J9qjawWGj9IA==
X-Received: by 2002:a17:902:c942:b0:242:9bbc:3644 with SMTP id d9443c01a7336-2446d9db047mr150258105ad.54.1755507763265;
        Mon, 18 Aug 2025 02:02:43 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d552798sm74284645ad.138.2025.08.18.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:02:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:32:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
Message-ID: <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>

On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
> @@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				/* GEN 1 x1 */
> -				opp-2500000 {
> +				opp-2500000-1 {

Why mention -1 here when there is only one entry with this freq value
?

>  					opp-hz = /bits/ 64 <2500000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <250000 1>;
> +					opp-level = <1>;
>  				};
>  
> -				/* GEN 1 x2 and GEN 2 x1 */
> -				opp-5000000 {
> +				/* GEN 1 x2 */
> +				opp-5000000-1 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +					opp-level = <1>;
> +				};
> +
> +				/* GEN 2 x1 */
> +				opp-5000000-2 {
>  					opp-hz = /bits/ 64 <5000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <500000 1>;
> +					opp-level = <2>;
>  				};

This looks okay.

>  
>  				/* GEN 2 x2 */
> -				opp-10000000 {
> +				opp-10000000-2 {

Why -2 here ?

>  					opp-hz = /bits/ 64 <10000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <1000000 1>;
> +					opp-level = <2>;
>  				};
>  
>  				/* GEN 3 x1 */
> -				opp-8000000 {
> +				opp-8000000-3 {

same.

>  					opp-hz = /bits/ 64 <8000000>;
>  					required-opps = <&rpmhpd_opp_nom>;
>  					opp-peak-kBps = <984500 1>;
> +					opp-level = <3>;
> +				};
> +
> +				/* GEN 3 x2 */
> +				opp-16000000-3 {

Shouldn't this be opp-16000000-1 only ? This is the first occurrence
16000000.

> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <1969000 1>;
> +					opp-level = <3>;
>  				};
>  
> -				/* GEN 3 x2 and GEN 4 x1 */
> -				opp-16000000 {
> +				/* GEN 4 x1 */
> +				opp-16000000-4 {

opp-16000000-2 ?

-- 
viresh

