Return-Path: <linux-pm+bounces-28859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2327FADBA97
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D4F189106C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741651FAC50;
	Mon, 16 Jun 2025 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="htstqk8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BA1E51EE
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104653; cv=none; b=YGbDiYEiRlqmc4TQJ7ftHS3GciR3UlRReJTJi0GdDaaawbdl0AlallgS+Zb00lCsB3eomTxrkt+LsCSUAhqYGa9aF5y7xxlUfS+WUdqlW9i84Yy8Cy8cu05FKW8WaRqaL3ZqYhTGnlylI1aQD5w0R3MykFhRD//v5GqoojFrL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104653; c=relaxed/simple;
	bh=siwzsEX/RsxClIOiFZuewcUx+IHCVT42sY6i74Oh+BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ52bfrD86OeuxvRHfPf36JtT0YlnU8u2pEfHuiwYFv4jo1ljCmRFSfdN9S+Lp/nUjC8LSWvaY6cR8nOv/TgZ1XwK5jts2I7JrX0+x4RAxz0SNaU/SV5EazzbvLmsGwNSsjXx/lbOKxU9IPeS2AfXLU2k9H6SDjQauEhz5VT70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=htstqk8Y; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0EB1C6D;
	Mon, 16 Jun 2025 22:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1750104638;
	bh=siwzsEX/RsxClIOiFZuewcUx+IHCVT42sY6i74Oh+BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htstqk8Y0Rykwt3+LehE+30nqRSil9MBl/yVLbgkkxgwFhZxL/C3hoVdVjKU3Ryka
	 rvYwdbtsudZBL2r916Ko3rIn6z1YaQaePc7v5XcCodV1oMnXK1kJ6VxCY66HxIGouM
	 QM2ynhMnP9xi4cSIhfpwvISr4XS12IGEdXZN+i44=
Date: Mon, 16 Jun 2025 23:10:33 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH v2 0/6] Update last busy timestamp in Runtime PM
 autosuspend callbacks
Message-ID: <20250616201033.GE32454@pendragon.ideasonboard.com>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0hEJ+XVdXGghLiF+KSvHCA=HorZXVR0vXkDaB_zxaM1WA@mail.gmail.com>
 <aFBudUgU2TWyDgn8@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFBudUgU2TWyDgn8@kekkonen.localdomain>

On Mon, Jun 16, 2025 at 07:20:21PM +0000, Sakari Ailus wrote:
> On Mon, Jun 16, 2025 at 01:21:02PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 16, 2025 at 8:12 AM Sakari Ailus wrote:
> > >
> > > Folks,
> > >
> > > The original plan for adding pm_runtime_mark_last_busy() calls to
> > > functions dealing with Runtime PM autosuspend originally included a few
> > > intermediate steps of driver conversion, including the use of recently
> > > added __pm_runtime_put_autosuspend(). The review of the set converting the
> > > users first to __pm_runtime_put_autosuspend() concluded this wasn't
> > > necessary. See
> > > <URL:https://lore.kernel.org/all/20241004094101.113349-1-sakari.ailus@linux.intel.com/>.
> > >
> > > This set extends the inclusion of the pm_runtime_mark_last_busy() call to
> > > the _autosuspend() variants of the Runtime PM functions dealing with
> > > suspending devices, i.e. pm_runtime_put_autosuspend(),
> > > pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
> > > pm_request_autosuspend(). This will introduce, for a brief amount of time,
> > > unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
> > > an issue. Also, all users of these functions, including those that did not
> > > call pm_runtime_mark_last_busy(), will now include that call. Presumably
> > > in the vast majority of the cases a missing call would have been a bug.
> > >
> > > Once this set is merged, I'll post further patches to remove the extra
> > > pm_runtime_mark_last_busy() calls. The current set of these patches is
> > > here
> > > <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm-direct-on-next>.
> > >
> > > It'd be best to have all merged within the same cycle.
> > >
> > > Rafael: any thoughts on the merging?
> > 
> > I'm going to queue this up for 6.17.
> 
> Thank you! :-)
> 
> > > Would an immutable branch on top of rc1 be an option?
> > 
> > I think so, but does anyone need it?
> 
> I guess it's not mandatory but we'll have now a lot of redundant calls to
> the pm_runtime_mark_last_busy(). It just doesn't look very elegant. In the
> end it's all up to what the maintainers prefer.

Those calls should be removed, but for the drivers I maintain, I don't
mind much if the removal is delayed until v6.18. Still, an immutable
branch based on v6.16-rc1 would speed up this work, and I think it's
worth it.

-- 
Regards,

Laurent Pinchart

