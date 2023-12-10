Return-Path: <linux-pm+bounces-867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6D80BA29
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0141C20840
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B37472;
	Sun, 10 Dec 2023 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZZunXtJZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340A6FAD
	for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2023 10:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F8BC433C8;
	Sun, 10 Dec 2023 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702204130;
	bh=EPfvKt783NSvXtsYYNiCEao1bf8wLKI/glmpIZjt+jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZunXtJZsn82CnIp9i/4OcEHYRKn2HH6W+Xe7Ikp0XFHoti5Z+efhTA4ixjFEOVEj
	 0+l3T7KmQP3voTNjVtyVpVB/hZ/zgVlYHSHqZawn4IP1jpC3Imf91W5uJt04GQBPls
	 bF/XQya3RT5gF+/e3rPDojVmcdrXBPKTVhEvuElE=
Date: Sun, 10 Dec 2023 11:28:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vimal Kumar <vimal.kumar32@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
	mintupatel89@gmail.com
Subject: Re: [PATCH v2] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2023121019-overgrown-scientist-124b@gregkh>
References: <20231210100303.491-1-vimal.kumar32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210100303.491-1-vimal.kumar32@gmail.com>

On Sun, Dec 10, 2023 at 03:33:01PM +0530, Vimal Kumar wrote:
> +EXPORT_SYMBOL_GPL(abort_suspend_list_clear);

Why is this exported to modules?

thanks,

greg k-h

