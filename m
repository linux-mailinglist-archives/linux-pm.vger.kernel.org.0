Return-Path: <linux-pm+bounces-25183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF0A84E3D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164EB9A54B2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96728F945;
	Thu, 10 Apr 2025 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bP4DjoNp"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4428CF63
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316995; cv=none; b=sijrJI8FBC6zM9hG52VDuxcPYWS0OplHeiIwC8hYj3EcdSLZU6xOP7jz67S5ysAI6RY9SoMLzqWa6Mf6xBoDvk5zTQeWh/d9VcV/yYyfa5dTiFAP6ukDypY+qAKgKejJ7GoXFUKg3qXpDkm+yDUaIi4NMNPFYVGPEb2Rylw+CPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316995; c=relaxed/simple;
	bh=esqPFtrE+hiE+dQ5wzwshItUJSMKvCEC41S2BYf+TNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rcr8ogVFjcKONStY8fapNKKrsrX9v4fPutVtdJP0W33DfbFnNlVRhDK30Dew2ComoY8mgm/84aDji3coF45Ja6GRhhdXzp6lsgC0AJUBpu9gZXsckgbggrH3JosPDn4CjmolfREpSQK4s9yJVESx1KCQf8VSX5uaaZ+wPMzrixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bP4DjoNp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15685352;
	Thu, 10 Apr 2025 22:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744316874;
	bh=esqPFtrE+hiE+dQ5wzwshItUJSMKvCEC41S2BYf+TNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bP4DjoNp9aeH/xDAgkX26rLr0Tb4ax1Q9TVVQR2/7hLgYfFsuUoCv5mOew/2RTvxu
	 GgdNOpRQsaQ+cJz9QolRcC2EKYUYinNbcp8XwT6P1Iu2TYljO5wwLnGOP8Go+kKQ72
	 0H3t0qowy1G9QtE3rY+IVwh2jbQA/5rtSmXDP8w0=
Date: Thu, 10 Apr 2025 23:29:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 7/7] Documentation: PM: *_autosuspend() functions update
 last busy time
Message-ID: <20250410202926.GF29836@pendragon.ideasonboard.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-8-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410153106.4146265-8-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Apr 10, 2025 at 06:31:06PM +0300, Sakari Ailus wrote:
> Document that the *_autosuspend() variants of the Runtime PM functions
> update the last busy timestamp.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/power/runtime_pm.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 91bc93422262..c8dbdb8595e5 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -887,7 +887,8 @@ instead of the non-autosuspend counterparts::
>  
>  Drivers may also continue to use the non-autosuspend helper functions; they
>  will behave normally, which means sometimes taking the autosuspend delay into
> -account (see pm_runtime_idle).
> +account (see pm_runtime_idle). The autosuspend variants of the functions also
> +call pm_runtime_mark_last_busy().
>  
>  Under some circumstances a driver or subsystem may want to prevent a device
>  from autosuspending immediately, even though the usage counter is zero and the

-- 
Regards,

Laurent Pinchart

