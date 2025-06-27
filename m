Return-Path: <linux-pm+bounces-29639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67148AEB077
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 09:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1B43A5218
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CB224B03;
	Fri, 27 Jun 2025 07:49:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96176221FA4
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010547; cv=none; b=hPak5npslkfpZ094B5ifJY2WDM6Qa3IYS47xKl5Ch4ZP3j+s2pkN+YLah4z1lWD+i4US6veo5D7oShJy2FbHTc85fNEMDJODE7NetcSSSK8CuOGaOsm8T5lPM/VKGzZN/hS79mu3RrNf+lgh3lPliDZaEVnkJd4YUnX5FmApwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010547; c=relaxed/simple;
	bh=dytr4BQPZi/bIx47Ud3AAQOO8a8GLVowIKGQT4bFWnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u2JoyJWl+xIIjjPs+sGxWxPzNwOBtlobcKMWmxahLAtgUiqkGnUt0gvGUGVpMi0GOAX8vDcmjlFqkvg9wY3S+1YT+Kc/detmpUG0jUXcYF9yrfDoH3cpFeEoscnGjjLdiVlke8agUeFy+ow5xI5IpPYLrDhENiJrAsLob+tNnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD961A00;
	Fri, 27 Jun 2025 00:48:47 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CB253F762;
	Fri, 27 Jun 2025 00:49:03 -0700 (PDT)
Message-ID: <7d43a796-d831-430b-92d9-53b3d8351fb6@arm.com>
Date: Fri, 27 Jun 2025 08:49:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question about behaviour of cpuidle on 6.6...seeing *many* missed
 estimates
To: Chris Friesen <chris.friesen@windriver.com>, daniel.lezcano@linaro.org,
 kgene@kernel.org, krzysztof.kozlowski@linaro.org, linux-pm@vger.kernel.org
References: <0dd1f3be-3bdf-44c9-a6d5-623077714149@windriver.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <0dd1f3be-3bdf-44c9-a6d5-623077714149@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/26/25 19:26, Chris Friesen wrote:
> Hi,
> 
> I've got an Ice Lake server running 6.6 PREEMPT_RT, currently using the acpi_idle cpuidle driver and the "menu" governor.  I'm seeing some weird behaviour with cpuidle and C-states and was hoping someone might be able to shed some light on what's happening.

Does your kernel include
3cd2aa93674e cpuidle: menu: Avoid discarding useful information
(since v6.6.93)?

> [snip]


