Return-Path: <linux-pm+bounces-9175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3449088DB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2601291ABA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD31946B1;
	Fri, 14 Jun 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7wzyTnB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3018413A;
	Fri, 14 Jun 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359010; cv=none; b=twLBpmECh5WqFb++V+ljzqQvWU5rpaWKbw39oh9U7jxehOjVTK1BjkmiFMTMgysJVNvCsVADETR/CtDhXjVHD8Q2WGGI1nuJui8oP0A6L9x/SlNRaZ/Tk/D2n/KkpBe+b9rrFvS0/Ywz3hFrrj8nxxemGniXrXtkWFm7/VQV+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359010; c=relaxed/simple;
	bh=6DYGtOO9fsxdii1hpiGiYZWqwQlEQq1h2D49dMbMRQQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CpCoUOy7i8JtGHw23asJ/son1AUpdOKoaDG1EwFI+LFC3zkUWHoeD4UvY7gBD1ypxf/zrUo96yBfbG/ZCLJxpjqBS8Mrt3SLUMIyeabceqlL/hAy1tZISqjL8QTAyd0nW/zxaG9VJVNu20wyPB3c8K8q5Rzs4o83+3GHK1nzwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7wzyTnB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359009; x=1749895009;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6DYGtOO9fsxdii1hpiGiYZWqwQlEQq1h2D49dMbMRQQ=;
  b=R7wzyTnByFV4VTGXGn6/9BmU1dGzNaTYzJeb1uibxzS6BVxbY3bB4ndj
   2PWqOmyZeR5zbhlYUUpIpdw7RauOPqQFFYyLRh1jJipFiOCiPtgHV+J89
   E6kj/UbVdW/E2tTcz0a/2+LZ54SB0AdPR11OlQEtTvphfLZQ7UZcxPW+u
   NuCu4ZG1rtsUgUl/RFbLQJXsaS8UaWB12z8w622u8uWSpqYMl01CI+1od
   NmsGm3O6VM1dkoqNxIQhsP5MPTi5+Y5sNlOfIPsjMnonNnWhf52ntnbgf
   IDKX26IfQoifF1wqd8SGUmG+JCdvsjoo+pEkffqfV5+Q45K5303x/cM1c
   g==;
X-CSE-ConnectionGUID: 9Wq/e2Y5QMSyJIIJdS0Rxw==
X-CSE-MsgGUID: ymEC7jjETmGEjRT8E0Zg1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14971391"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="14971391"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:56:47 -0700
X-CSE-ConnectionGUID: LRiMHZYsRsqibI4JLf4H4Q==
X-CSE-MsgGUID: 0+1ZhNyBQXajci9fHR11Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="41131343"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:56:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 12:56:36 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v7 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue
 driver
In-Reply-To: <20240614-yoga-ec-driver-v7-3-9f0b9b40ae76@linaro.org>
Message-ID: <9b753f90-2cb9-efbd-bbfc-a09ab2196a78@linux.intel.com>
References: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org> <20240614-yoga-ec-driver-v7-3-9f0b9b40ae76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-413572503-1718358996=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-413572503-1718358996=:1013
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 14 Jun 2024, Dmitry Baryshkov wrote:

> The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
> the onboard EC. Add glue driver to interface the platform's UCSI
> implementation.
>=20
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-413572503-1718358996=:1013--

