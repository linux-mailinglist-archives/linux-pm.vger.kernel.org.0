Return-Path: <linux-pm+bounces-179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64477F7736
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 16:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E385B213B1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61F2E627;
	Fri, 24 Nov 2023 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pdevLJfV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84392C1AE;
	Fri, 24 Nov 2023 15:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF88C433CA;
	Fri, 24 Nov 2023 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700838350;
	bh=Lw4ddp5SRRaHbNDe7CMkDvQErv4vbWF/4A45oJbqhsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdevLJfVyCSjjA1P3fYUGSKdZZHBnKVrNkLw7Bo/RLiSgERLtxK3EsjDDdBh7DfSp
	 BT/ltxx8EX+6aPl761mJCK+kBsI6Xj4Yqpi83meTzIS1A9hSbNQaUUx8qyURovyDs8
	 bN4RTVQiSHWV/s3DuiLmJUV7jYFviPxaOWnynjLc=
Date: Fri, 24 Nov 2023 15:05:47 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112403-laxative-lustiness-6a7f@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124145338.3112416-1-o.rempel@pengutronix.de>

On Fri, Nov 24, 2023 at 03:53:35PM +0100, Oleksij Rempel wrote:
> Hi,
> 
> This patch series introduces support for prioritized device shutdown.
> The main goal is to enable prioritization for shutting down specific
> devices, particularly crucial in scenarios like power loss where
> hardware damage can occur if not handled properly.

Oh fun, now we will have drivers and subsystems fighting over their
priority, with each one insisting that they are the most important!

/s

Anyway, this is ripe for problems and issues in the long-run, what is so
special about this hardware that it can not just shutdown in the
existing order that it has to be "first" over everyone else?  What
exactly does this prevent and what devices are requiring this?

And most importantly, what has changed in the past 20+ years to
suddenly require this new functionality and how does any other operating
system handle it?

thanks,

greg k-h

