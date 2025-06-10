Return-Path: <linux-pm+bounces-28336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40451AD2E66
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 09:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194D01886A5E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABDF279782;
	Tue, 10 Jun 2025 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb1cbvFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1321D594;
	Tue, 10 Jun 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539484; cv=none; b=UjabY6ignjxDJ9LCmEYSwZna4jktpsO0xjhqz3u49ipKV2y3osH2P4qzDHdwQfLVhC2GYR2ehk7wzQL5nP7f8wIv1NufWi/Me/Vvvb+YArYJcrllPVEJxQhjB/CeCrhhhz1hsymBCtKcoOL8q8q35WDPv/1+QCtOM1piPi/6IGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539484; c=relaxed/simple;
	bh=neg1A76eaomaWdPPybsDSsKC2N8/KM8/tJFtzbUDeQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4x/Ty/ibu9cPu/R19p4ykClwfLR8I95kbqVapiU4yfYaie+vzmO8dgZE948hS+8RhR4x4HPBTKL3ooIwO2GrTaAZuDWgt98r0ebKZLa55/R847+TrjKYNeU//rwZJI+ryawJ/5mVD5zbiJ+HUJ5spnxXoMixUwg/DDQfiulcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb1cbvFk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749539483; x=1781075483;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=neg1A76eaomaWdPPybsDSsKC2N8/KM8/tJFtzbUDeQI=;
  b=Lb1cbvFkj/jcj7nbN859a2Kmst1e6SNtuffSFxpndhp9Nr8w3DWK5Nxb
   qAjkPq4QyEYHGwXvBdmLU9955hsdXZBJJSCzdaG2NtnOZwimIHygxOyc2
   A1my9p6jRxxrTLHfu4hXb3OuBzzXjosvurG9mjMaKwIebzLsOEcmeR9Y5
   gFRTMyGWwzm1qrTh+ehQVhgLz7HrxDQXI4P6mJuKZl/Nw1Qt3M8vC4uDl
   Y+kuGpK6Lh6QQjwoo8aCQBKJe5OJQOEsp+FRkJqo9Z01kXIWYdxhLGK6y
   lGXwWD+d0RMt4/yuIRf0gEXY5dpC3gZQanr8wV+vx2KeiWoNDVZGy0XuA
   Q==;
X-CSE-ConnectionGUID: KiQmpX5qSv+e+rW6xvT4wg==
X-CSE-MsgGUID: Veji9aVoStaiTp6Rt6vZ8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="77035783"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="77035783"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 00:11:22 -0700
X-CSE-ConnectionGUID: TEzqJQhwTUWSr90uhVp86w==
X-CSE-MsgGUID: G9TJos/lQQm0epoSmo45Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="183932960"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 00:11:22 -0700
Received: from [10.245.244.218] (unknown [10.245.244.218])
	by linux.intel.com (Postfix) with ESMTP id BE41420B5736;
	Tue, 10 Jun 2025 00:11:19 -0700 (PDT)
Message-ID: <d8482e4cb4384fa02d61a6d80075be363598734b.camel@linux.intel.com>
Subject: Re: [PATCH] intel_idle: Update arguments of mwait_idle_with_hints()
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Date: Tue, 10 Jun 2025 10:11:18 +0300
In-Reply-To: <20250609063528.48715-1-ubizjak@gmail.com>
References: <20250609063528.48715-1-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 08:35 +0200, Uros Bizjak wrote:
> Commit a17b37a3f416 ("x86/idle: Change arguments of mwait_idle_with_hints=
() to u32")
> changed the type of arguments of mwait_idle_with_hints() from unsigned
> long to u32. Change the type of variables in the call to
> mwait_idle_with_hints() to unsigned int to follow the change.
>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

