Return-Path: <linux-pm+bounces-39826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A367CD869E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 08:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B633013EAE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108D30171A;
	Tue, 23 Dec 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIBGXri0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DE2D0C8A;
	Tue, 23 Dec 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766476565; cv=none; b=rkdRMO9+TdXZsEiFoBnC80xsj4iagOT5v6BjpDNVPaX04HMXT+kM5IQxWK1VxakTaB6X4w69FrnVFslKF02MhsxwTm72/AkwEU3/+MUUH+oZiaA6D9x0Zqsci2FBa27zpNkoEjRPhYjzjSxynyDCebUqRpcF9idTQXG6F50HMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766476565; c=relaxed/simple;
	bh=+p6/YhsUc9LxaFM70P7JXp3Az4jq6kXo7hFAA5UBS44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abfxlhTNfc3z8DXGhW+Fc932kV84rTzfQyg6WiouvSpYoVOt7OjK2GAhIO41hOjPYVQUVtovUCMmO2mg7EBWW+7TEw5pZ53p8DjjV2AExELYxJIKf08w2Fyfh4ErIR/z4gEZJireoZsMFBvj4+N8hC7O0fGuRNI/gWbcGKepNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIBGXri0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667B7C113D0;
	Tue, 23 Dec 2025 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766476564;
	bh=+p6/YhsUc9LxaFM70P7JXp3Az4jq6kXo7hFAA5UBS44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIBGXri0IRmSHopnJ+IP2CGZXFANURsU9DhrFz3EIz+bmZYvulr3M0oN3CwlMo9cK
	 +Vf710U0Ko26ySqmE0lNfqjQbg6BBDZqtQlAwEj3yA/Zri2z70WhQNwnrsBYjlKly4
	 uC9d49hc/ig3HbyAl0VeRl6mXtnnKpLXBB51Z1Uw=
Date: Tue, 23 Dec 2025 08:56:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>, linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v1 02/23] USB: core: Discard pm_runtime_put() return value
Message-ID: <2025122350-skewer-celibate-1be5@gregkh>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <5058509.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5058509.GXAFRqVoOG@rafael.j.wysocki>

On Mon, Dec 22, 2025 at 08:52:33PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To allow the return type of pm_runtime_put() to be changed to void in the
> future, modify usb_autopm_put_interface_async() to discard the return
> value of pm_runtime_put().
> 
> That value is merely used in a debug comment printed by the function in
> question and it is not a particularly useful piece of information
> because pm_runtime_put() does not guarantee that the device will be
> suspended even if it successfully queues up a work item to check
> whether or not the device can be suspended.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

