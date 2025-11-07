Return-Path: <linux-pm+bounces-37644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9078AC41564
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C17C4E669E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2F2E7F00;
	Fri,  7 Nov 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnIM8Sdo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D392DAFD7;
	Fri,  7 Nov 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541261; cv=none; b=Tem2nYDViQMpgWdy2do+TKUbC+fa2VbrWamzYoU35D1Bty516RK3PdK7/UhajN9naCgVBQ/ShhlKWj1csG72ad1Q3yMuL5YvPY+ZZa+oPmPZetxZqWF6tlWd4VNUE3ZIFrtIPiedNmOD3aglvBTRxxEnJdBNoSJsd/K1Hr4lrBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541261; c=relaxed/simple;
	bh=MBYEgML9xeAqoHhLBXAHRikDAexWLU0pW8dUQsj3V1Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=RwSLS4/sZdYd1cVOGWyIHhl2NBCQuO8PbmUNsmeLhC+WZYFxNraYnuefqG9v3ag3BRnKQ47BXEXvgLXrGUwj7700X7OTvFvtkoomyH5Y2r37D401Y8Sad0mMk14X6a6xSIYF0PxaH+YvvatfNYCTL1/cejNCNGKKMLrgLm6OxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnIM8Sdo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762541260; x=1794077260;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:mime-version:date;
  bh=MBYEgML9xeAqoHhLBXAHRikDAexWLU0pW8dUQsj3V1Q=;
  b=FnIM8Sdo7nVxokK3dhXvN6E7kbowLJJyNmMMYjg/L1H74d0IzWRSMFKN
   fpr+WYWqhbsFigwZJAeaxke52IwHpB3h+XtnEqaASAez+zRV6JIxIumg8
   bvNFIehLZh0JkcL+mWCaXrqqNYMhsXLF4IG5zHx0jgOhrBkIIqQ38CZfe
   ISQMl2FSGph61VSc9XXhwLVrjLkZJ+QAQYKO9vkzV+LZV8xLPoaLDb8yG
   NoVVa0YRrx+uBxWG+wbzNcvsH/VsvG50ZDkiORcwpc5GA/ku4FoU+VW9d
   1LEYd3cE7LMSMAM3P96yqIUA45zUfv1X7MAQ5PgUQtQv7p/0cRZNjEGBg
   A==;
X-CSE-ConnectionGUID: PAKHbQm8SJuI/uwUvqqJ+Q==
X-CSE-MsgGUID: jtVbfgwuT5WrSB9D0A6PUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64735706"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="64735706"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:47:39 -0800
X-CSE-ConnectionGUID: sQ3H9dx8TKS4Od4vej+7Ng==
X-CSE-MsgGUID: 9uADhjd8QY6YrCGYGLAvMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="211546391"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:47:38 -0800
Received: from [10.245.245.126] (unknown [10.245.245.126])
	by linux.intel.com (Postfix) with ESMTP id 8C06620BA6F5;
	Fri,  7 Nov 2025 10:47:36 -0800 (PST)
Message-ID: <a8d3fe252f5ed9d513c026331eeabfe5971196b1.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpuidle: Add sanity check for exit latency and
 target residency
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>
In-Reply-To: <5939579.DvuYhMxLoT@rafael.j.wysocki>
References: <5939579.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 07 Nov 2025 20:47:20 +0200
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 

On Fri, 2025-11-07 at 19:19 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Make __cpuidle_driver_init() sanitize CPU idle states so that the exit
> latency of a given state is not greater than its target residency which
> would break cpuidle assumptions.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/driver.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -193,6 +193,16 @@ static void __cpuidle_driver_init(struct
>  			s->exit_latency_ns =3D  0;
>  		else
>  			s->exit_latency =3D div_u64(s->exit_latency_ns, NSEC_PER_USEC);
> +
> +		/*
> +		 * Ensure that the exit latency of a CPU idle state does not
> +		 * exceed its target residency which is assumed in cpuidle in
> +		 * multiple places.
> +		 */
> +		if (s->exit_latency_ns > s->target_residency_ns) {
> +			s->target_residency_ns =3D s->exit_latency_ns;
> +			s->target_residency =3D s->exit_latency;
> +		}

I suggest to error out instead of capping it. Because as soon as you
cap it, you may end up with the target residency of the next C-state.=C2=A0


Just erroring out is very explicit, no surprises, and the table
provider will have to just fix the table.


Thanks, Artem.


