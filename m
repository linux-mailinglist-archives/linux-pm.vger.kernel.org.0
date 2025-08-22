Return-Path: <linux-pm+bounces-32922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B899CB323D8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 22:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8131A17E7CD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B42FCBF7;
	Fri, 22 Aug 2025 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="DJQSXnrc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884AD2BCF46;
	Fri, 22 Aug 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896170; cv=none; b=CAOVvPzFwk/66bMWiGJbK412+uI9SLyGVDn4Erj7T3OYBKs07iHdxSASHd53kUCZKlNw9E5MDkhzelsV7XWIUI9bww5TLTlwrzsyJn4W2H/L/YmU8REWj5r8+JXM7Ng/C4a8NqKq5GcwTSX8Yg91wFlJ/iTwjdUefMm+RUuPao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896170; c=relaxed/simple;
	bh=PHG0D5CzDDTIfrFFxjd2HcsgBLjTrNlrvcq+F1lz+2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIaUPFYQwCcX9W0gKpk1T7J1DBeapwWghSE0tFa17ZKZHRAblHCG2WGJq+d+JiBLwasjh5AtvTefgX88wLuR2OixzRR2Uol29t89NdEjLfL5YbDVT2GDCIC/8D5P03Dyny1PhpZb3/4+yRGWkbUTGSCxoqa3rvpe3nYgffDvCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=DJQSXnrc; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=jfIU0fuoE9yXlwzwCsY58yVMK25YpgK8FBL6dKXlTGM=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755896103; v=1; x=1756328103;
 b=DJQSXnrcX1KtXFD8wN/IsWAeXiCKnnn69GH/KEJ8BExviuHhDhgNduzZ4liRcUICrKbL8W2N
 pO8i7R+txU/wZSYMNRNtNWYFPdDbJ3Z1IIsaRL2ln0OdCUQglEMuQI2pA3Rm91tZPhTiW8OI/vi
 BLgWP8MoT8TQCaiBDXJB2kdBLl28Yt2TL5osaCRM4ZYKKfPB3HarwCjt9pkDDw0L15SQZJZ0qPk
 098W7wjKzHXepBiTHHF3EpS9d9FU3erH5/TcFi58UNKCPONunJkaBtN7rgvvK/VdifKBsAkBghW
 tdwOVaFmp/ScFDObBX+vJ5gMSk5hKIH9+r2X/V5UQGLsQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id b22c5fac; Fri, 22 Aug 2025 22:55:03 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] clk: mmp: Add PXA1908 power domain driver
Date: Fri, 22 Aug 2025 22:55:02 +0200
Message-ID: <6193521.lOV4Wx5bFT@radijator>
In-Reply-To:
 <CAPDyKFoHWNuSmnN0e=QR73r0Ea-XJogbB8S3K+_=VRovzXL2Sw@mail.gmail.com>
References:
 <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
 <20250821-pxa1908-genpd-v2-3-eba413edd526@dujemihanovic.xyz>
 <CAPDyKFoHWNuSmnN0e=QR73r0Ea-XJogbB8S3K+_=VRovzXL2Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 22 August 2025 11:36:02 Central European Summer Time Ulf Hansson 
wrote:
> By looking at the implementation of the power-domain code below, it
> seems to me that this code is better maintained within the pmdomain
> subsystem (drivers/pmdomain/pxa perhaps). May I suggest that you move
> it there.
> 
> I guess the easiest way to do this is to export the
> pxa1908_pd_register() function - but you could explore using the
> auxiliary bus too, to instantiate a power-domain driver as an
> auxiliary driver.

The auxiliary bus was exactly what I needed, thanks. As for the path, I think 
drivers/pmdomain/marvell would be a better fit and I'll go with that if you 
don't object.

Regards,
--
Duje



