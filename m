Return-Path: <linux-pm+bounces-18076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B19D8829
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F842825A1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A261ADFF7;
	Mon, 25 Nov 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRo3sWgL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614601B0F22;
	Mon, 25 Nov 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545432; cv=none; b=C8Kp73LeGUhtuEC0YXTcQofdmb7EQ8bPurtCjhIU12efzu1lTUBDFUMYcNpHbu3+l/ffFgVt52a5HH0CsnqHkoMjOM5YAIs77XLALFsmetP3npjjwWqBeI8zl/QIwyZJg2Jn9pYn21di+HFY6S/GSy1Yhynjvshcn9GIuadQq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545432; c=relaxed/simple;
	bh=3LGA9jSWinJSoEyWozkix/rPCB8C+JbwGtTNX3pe7VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKXPbWE6oq/RarsuUpuTKQcQejfyzr2LnpGtvkdkFcjWwShEXNhgS2VDQLzsJkXFpA6ZWudj+/1ERmT1GRrK8SWlpB/JR6ePpHVttnNVM/JKykBnFtQAqstFLz7PfY+jY/bzFnWuAzRS4TReVWbg3lObd8LNKyqqQbqbEuYP+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRo3sWgL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732545431; x=1764081431;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3LGA9jSWinJSoEyWozkix/rPCB8C+JbwGtTNX3pe7VE=;
  b=lRo3sWgLhVZlT8zSrZYSrOEodCjCuVkNgejuFozb9aXRlvywxGGeYoTO
   +WfjL/V5Vo6FIPSIEXAN2UpmYUtkmU8kMeMGgTIVUt+cYu9mxqWidnCQ3
   ZyBDZDgz26iur1ZgMSqpBjpdKdCcx+rSo8CgCGjcLa74FUS2Tj01+YS8V
   inrpY/wiX83kBxaIUHqmM73xVk2l5vo94qEA4JQAXd+JbN8hUNNQ0opO+
   pdft0cBej0Y7sHvgEjAN5Bm/LIG5mpVCTA9xPz73aILoDDJxVQmRRgb3R
   iwcZjI9bT2AToOz6rdUSWYqREcnOYn6Iv7bJTRexs0X/1jxm9+3xXnv7B
   g==;
X-CSE-ConnectionGUID: eKh0jlukS3GHmAyN9dPHAA==
X-CSE-MsgGUID: DwcGjIohT1+R1MjI3N9Uaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32912455"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32912455"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:37:10 -0800
X-CSE-ConnectionGUID: lIl27DT4R52g8Ss3WX3i8A==
X-CSE-MsgGUID: d1Dh/EVpSM2T5YVxW8PuKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91747921"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.34]) ([10.245.245.34])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:37:05 -0800
Message-ID: <4ef421bd-2436-4bfc-951a-52e0ea2d020d@linux.intel.com>
Date: Mon, 25 Nov 2024 15:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/8] cpuidle: Do not return from
 cpuidle_play_dead() on callback failures
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-2-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0hG4gJEZW-53Ps+AUPdkZCubH2Px35BmN1_goRTMb9EeA@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0hG4gJEZW-53Ps+AUPdkZCubH2Px35BmN1_goRTMb9EeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> This one and the [2/2] are in the mainline as of today, no need to resend theM
ACK. Purely RFC. I just want to make sure we are all on the same page.
I'll rebase when we all agree on how to solve the problem.

