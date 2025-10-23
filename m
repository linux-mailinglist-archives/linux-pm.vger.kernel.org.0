Return-Path: <linux-pm+bounces-36723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84BC014ED
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A89235A7AB
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4920309DA4;
	Thu, 23 Oct 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxmVdUOU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0402D8376;
	Thu, 23 Oct 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225393; cv=none; b=mZS68TLLYAJmxODql3zyIgdHcApyDtJfmyjGFfEcY8RYF8Sws2rHsKDCC8Buos2tx32k2qMA5wQDrp/xBY+VkdrAZv2TQ6h7/ZZAqvKc2B8R0BYjrnt44hLk7WlaM0yoUVsLpG9Q7MSbGO9SJD7xBQU3zh32xo87Mnipr4eOcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225393; c=relaxed/simple;
	bh=YQDmoO4INHOfFm3/n0OrmMLsG8xMDbunxnfN1QKYRh0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J0GJzkwniWVhWkw9ngjtu3dk0/yXSrxO/QBoMEkES65dkn+eFx9QdpL8a/HAvivZHcQz0DabkTF2WEpMXkJ6LsR3SjlMQxuBv5GQu1AlvihLeN9qZWxX7CSbOwXoniZk349Lm3MSxQ/udpxBEFpSVM9bvFLtZdemPUBUBlDeaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxmVdUOU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761225392; x=1792761392;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YQDmoO4INHOfFm3/n0OrmMLsG8xMDbunxnfN1QKYRh0=;
  b=gxmVdUOURor/J1JDtQF5FSTiGqaz+SytYcfKw1aLBgdu7gMKxKrMJN9r
   wmegRQ0g5y/EaqdiIcey8ZOYfL6T8v5sD/4E+1jsDJjZor547lV1kwzxZ
   yvjp7J0/sLCxRH4juuXZz8kftzjperIj+a7l0cG+8m1i1k4QQKwDxPuMA
   1X57j98XdtVQr1S2VeQ8waJRyoJv/L0pPX6R8cujQ7TwhJQTB8ayV2awi
   QNM8Btt4D1B1G5SP6dlmgSSNHR9TAMQll6KTZGIk2ix4NQe5k0QHgP+Tc
   bVyS4anPOCaO45LgLoQm4nUw//L9SRDA5Hhz+Ym6t+LRhbli1M8jmGNDO
   A==;
X-CSE-ConnectionGUID: wE2ufBbPQju95A4cJU9Jww==
X-CSE-MsgGUID: cVk9qCBlSW2a9yqoDlUPKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88859477"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="88859477"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 06:16:31 -0700
X-CSE-ConnectionGUID: FhBWbybsRVqhCHzCIbEAog==
X-CSE-MsgGUID: /zvWZUUrSkePbDxaWFkcDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184047125"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 06:16:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 23 Oct 2025 16:16:25 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Ulf Hansson <ulf.hansson@linaro.org>, 
    Brian Norris <briannorris@chromium.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1] PM: runtime: docs: Update pm_runtime_allow/forbid()
 documentation
In-Reply-To: <12780841.O9o76ZdvQC@rafael.j.wysocki>
Message-ID: <ce2201d2-5c34-1cc9-9766-884f1f79e38c@linux.intel.com>
References: <12780841.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-643476600-1761225385=:1016"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-643476600-1761225385=:1016
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 22 Oct 2025, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Drop confusing descriptions of pm_runtime_allow() and pm_runtime_forbid()
> from Documentation/power/runtime_pm.rst and update the kerneldoc comments
> of these functions to better explain their purpose.
>=20
> Link: https://lore.kernel.org/linux-pm/08976178-298f-79d9-1d63-cff5a4e56c=
c3@linux.intel.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/power/runtime_pm.rst |   10 ----------
>  drivers/base/power/runtime.c       |   17 +++++++++++++----
>  2 files changed, 13 insertions(+), 14 deletions(-)
>=20
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -480,16 +480,6 @@ drivers/base/power/runtime.c and include
>    `bool pm_runtime_status_suspended(struct device *dev);`
>      - return true if the device's runtime PM status is 'suspended'
> =20
> -  `void pm_runtime_allow(struct device *dev);`
> -    - set the power.runtime_auto flag for the device and decrease its us=
age
> -      counter (used by the /sys/devices/.../power/control interface to
> -      effectively allow the device to be power managed at run time)
> -
> -  `void pm_runtime_forbid(struct device *dev);`
> -    - unset the power.runtime_auto flag for the device and increase its =
usage
> -      counter (used by the /sys/devices/.../power/control interface to
> -      effectively prevent the device from being power managed at run tim=
e)
> -
>    `void pm_runtime_no_callbacks(struct device *dev);`
>      - set the power.no_callbacks flag for the device and remove the runt=
ime
>        PM attributes from /sys/devices/.../power (or prevent them from be=
ing
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1664,9 +1664,12 @@ EXPORT_SYMBOL_GPL(devm_pm_runtime_get_no
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
>   *
> - * Increase the device's usage count and clear its power.runtime_auto fl=
ag,
> - * so that it cannot be suspended at run time until pm_runtime_allow() i=
s called
> - * for it.
> + * Resume @dev if already suspended and block runtime suspend of @dev in=
 such
> + * a way that it can be unblocked via the /sys/devices/.../power/control
> + * interface, or otherwise by calling pm_runtime_allow().
> + *
> + * Calling this function many times in a row has the same effect as call=
ing it
> + * once.
>   */
>  void pm_runtime_forbid(struct device *dev)
>  {
> @@ -1687,7 +1690,13 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
>   * pm_runtime_allow - Unblock runtime PM of a device.
>   * @dev: Device to handle.
>   *
> - * Decrease the device's usage count and set its power.runtime_auto flag=
=2E
> + * Unblock runtime suspend of @dev after it has been blocked by
> + * pm_runtime_forbid() (for instance, if it has been blocked via the
> + * /sys/devices/.../power/control interface), check if @dev can be
> + * suspended and suspend it in that case.
> + *
> + * Calling this function many times in a row has the same effect as call=
ing it
> + * once.
>   */
>  void pm_runtime_allow(struct device *dev)
>  {

FWIW,

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

(And I didn't check that "many times in a row" claim from the code but I=20
assume you know things much better than I do. :-))

--=20
 i.

--8323328-643476600-1761225385=:1016--

