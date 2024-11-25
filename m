Return-Path: <linux-pm+bounces-18077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266879D8836
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC00E1639B5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA991ADFF7;
	Mon, 25 Nov 2024 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f29per6y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEC16419;
	Mon, 25 Nov 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545566; cv=none; b=udkYsHh4FIwHReH0mo6szMnS4y5u2KmpZvjcYVRoBFSB2+zcq431Ihpkq+y635Si4bcDhHQVzGHleBElJDYoWKSNdniVQWTxvWVz/SoJcOMH3AX7NAddy4rskSo6tB+0b8HFsLW9fAuKowQCvf7SzCueXK5H7QE9Hbct7MPuS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545566; c=relaxed/simple;
	bh=jQAOxEulifX9JAhYbllSyYvMlOUUXbwE51VuzcuqbO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tH1PzlYugLQ/mlMUVe7gkO4kWEJmA9MJ0qxuzItkt0Q0l4rAvKxGwItGOi0ibvpBt9S5IAj+n+mlEGZiGfOU08QWcDaozKSlHgo1JQnPmSj2hBGvoI0sVs4AxcqIESis11X0ZF8ffYnh6G9PXFlSNe3PjJ80pp3rD/XF1gqtIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f29per6y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732545566; x=1764081566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jQAOxEulifX9JAhYbllSyYvMlOUUXbwE51VuzcuqbO8=;
  b=f29per6yjCgTY+dQGLiVSZ9O6DWj2M36qRz6onXVVu0PeTMy5oa50yfG
   LWF8HYdP9R2Pw51R2zj3FuAsv5151+iP37l8I+bbRrmCOVyBzzZGxfOyY
   5xdHHr1GMW8FaEOM4fe3gDj+yNUtv2FOOGL4XdhtV+L6igyL35BA6/He7
   LFi7oRd1pHsO8Qdtcqqu0W2Fz2AMfD17R+B1bTX+VSoyrYWXENMD21fBD
   dohjnpqOg/WDOYHCwtHYcoa7PbvJZbS8AaoDp7sxCLOs7vF75JFY2Tz1o
   tZjTiu+0wI15QPKoue3ZHpxcbBlBbTZu+3HzznJXPpCfy+P8YqRTk+WxT
   A==;
X-CSE-ConnectionGUID: kXqhNeBHTj6LgpTP755R3w==
X-CSE-MsgGUID: FyhzSCMxQ1SsppopAyOjJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43155643"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43155643"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:39:25 -0800
X-CSE-ConnectionGUID: osQG5IQkRqSupgvPl8rubQ==
X-CSE-MsgGUID: ugzGiG99TX++FUpyb7pXVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91418769"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.34]) ([10.245.245.34])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:39:20 -0800
Message-ID: <92bf50eb-e260-4c7d-a157-b830b6c4e835@linux.intel.com>
Date: Mon, 25 Nov 2024 15:39:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/8] ACPI: processor_idle: Use
 acpi_idle_play_dead() for all C-states
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-4-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0iD30S1EyfqtV1_RDrxTCDmgbOA60njkdWpNzmpEAGXhw@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0iD30S1EyfqtV1_RDrxTCDmgbOA60njkdWpNzmpEAGXhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> This already is in the queue of patches to be merged during the 6.13
> merge window.
>
> I gather that it has been included here for completeness.
As in the previous email.
Just an update to the series. Purely RFC. I'll rebase when we all agree.

