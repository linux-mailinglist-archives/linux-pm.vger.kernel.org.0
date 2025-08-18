Return-Path: <linux-pm+bounces-32542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AAEB2A18C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B95A24E2C5D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB34322743;
	Mon, 18 Aug 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXJrAf+U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A332145A
	for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520093; cv=none; b=opvRMbug0hJzg4FEukdi2V0pupy+q956klffJhrQuHacR4kM8lUwUoekGWZ3/qrhabr/JGDCS6E0Z+DUw0d8r6dRBrxZqcisvDqqRT/Zx7AL/+MC35D2PsFxSKZZbQIFRYBOOUVk9TwXILeEbyUKeuabmXxU7LpmSswB/hGr9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520093; c=relaxed/simple;
	bh=XiB2YxYxJL06GqxQOoOpjVh/9fzUowLPh9sr5pAMAzY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDbE3TX4DodjX4IDTDj17BwjEitKqfY8SdV0nlwYIRVlzomlymSQmAJMTtjqRMpAzn2UKy2w097hMM7S5oDprisOqH+G8+/NN0wrgq6R9hQNcsGzYA9ar8LB7ahwF4YS1AWffZAQpqYNEd2BwPCUi431GGHh6PPRUjvXKDDlZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXJrAf+U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755520092; x=1787056092;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XiB2YxYxJL06GqxQOoOpjVh/9fzUowLPh9sr5pAMAzY=;
  b=PXJrAf+UHGJ9Uu/Vs7q/wqnGbHd04hMdDfZs0YqUM/iP1s8qAi083wSv
   71TIBmaliTdKR3rU71PycNBya5GtKwqidlnv9lK1Xn5x5cJSTXcsL2K+K
   /6hDdfrZHKs7dECqXFQul6B4SUvl1Ep5Vd+7G1NzaCjE3szMwrfmYSxGm
   XpCBxtBmt4RKNt91VKaKnUbQ3JJKd1UWLI06X5MF3LxLxrO22Xxq1E398
   nXzdv+5xZjpTQQmCv7Bt+k25RrLNWDrPNnxlfkNtm/Ep7BUs/AJ/09/jh
   rS1rKyQ1kIhkLzRaBoDfXMkxI93cajcbsE/RlYJI15y/A9nN7zPgvsFOv
   Q==;
X-CSE-ConnectionGUID: Tawj2l00SqecnHHP03B1Gw==
X-CSE-MsgGUID: l8HGadTHRHaxIAm72+u5tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="61367345"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61367345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 05:28:11 -0700
X-CSE-ConnectionGUID: yTZi5HSSRoCIZ9hsedg5Vg==
X-CSE-MsgGUID: i5ufTaEMQUGpJha2YJ5RDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198574584"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 05:28:11 -0700
Received: from [10.245.244.6] (abityuts-desk.ger.corp.intel.com [10.245.244.6])
	by linux.intel.com (Postfix) with ESMTP id 75CC620B571C;
	Mon, 18 Aug 2025 05:28:09 -0700 (PDT)
Message-ID: <8024bc1249dd1f6ec8496f46a119f009823259be.camel@linux.intel.com>
Subject: Re: [PATCH] intel_idle: Remove unnecessary address-of operators
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org
Date: Mon, 18 Aug 2025 15:28:08 +0300
In-Reply-To: <20250818085124.3897921-1-kaushlendra.kumar@intel.com>
References: <20250818085124.3897921-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 14:21 +0530, Kaushlendra Kumar wrote:
> Remove redundant address-of operators (&) when assigning the intel_idle
> function pointer to the .enter field in cpuidle_state structures.in C,
> the & is not needed for function names. This change improves code
> consistency and readability by using the more conventional form without
> the & operator.
>=20
> No functional change intended.
>=20
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

