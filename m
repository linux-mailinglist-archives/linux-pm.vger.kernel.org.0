Return-Path: <linux-pm+bounces-14642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16E98530A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7024F1C22C5C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71B2155385;
	Wed, 25 Sep 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17CTynks"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0213D508;
	Wed, 25 Sep 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246447; cv=none; b=UvFienfG3iotsNLpXKXNOUE8fplPMW071Xe0HcUC0ulUkaxwrp2plH3KRZONTlp+eUVU46Qe5vdf9ikQzHSB1xFOT0C5MWFmDWMWYp3Wp0nl/8aVA3/swfsPjZex6A2q8SAlQAlEMlOhTfZxUsbUKNp08LZZ3oKuufLGDS+dVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246447; c=relaxed/simple;
	bh=iQIKQE0vVaTKBuk81h3G63n44CCBRTztZtJQG/783gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goUyYmZ/uRN4D8pb6sJd5fQLpN58Ip9l0YVMQj9qCZBFSxRwLlahyH/5/CzPIff0TmvU4i29ZwEPvpALfy673tvhfTNZwSnsgEdWKVv3wYN0niLgoa/yy+vi/JebBz9R92StQDXEbOMSjCqf1neeSky7cZ3AID3oaV3KVwhYWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17CTynks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C60C4CEC3;
	Wed, 25 Sep 2024 06:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727246447;
	bh=iQIKQE0vVaTKBuk81h3G63n44CCBRTztZtJQG/783gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=17CTynksmIsiMrPWPJxhIuVCIdEYBxIp098B6xF3coopY6gKNjTGS8udO2SZqIB0u
	 LcH7gHZLz/3VZXnTqw2cN1uV7/KsApHroiPkviXEyvVLw4EmtOu0y9oM5iPPu+qASv
	 o4ek3B1ANg/9J54zZWyo9ZANtbCFP9O9reu+ruRY=
Date: Wed, 25 Sep 2024 08:40:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dengjie <dengjie03@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, xiehongyu1@kylinos.cn,
	duanchenghao@kylinos.cn, xiongxin@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where
 task resumption fails due to USB status
Message-ID: <2024092513-stout-subsidize-0c71@gregkh>
References: <20240923100553.119324-1-dengjie03@kylinos.cn>
 <20240925025041.149206-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925025041.149206-1-dengjie03@kylinos.cn>

On Wed, Sep 25, 2024 at 10:50:41AM +0800, dengjie wrote:
> Reproduction of the problem: During the S4 stress test, when a USB device is inserted or
> removed, there is a probability that the S4 wakeup will turn into a reboot.The following
> two points describe how to analyze and locate the problem points:

Also please wrap your paragraphs at a much narrower line length like 72
or 75 characters or so.

thanks,

greg k-h

