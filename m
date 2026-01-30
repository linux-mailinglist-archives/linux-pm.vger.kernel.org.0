Return-Path: <linux-pm+bounces-41798-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IynGRgGfWmpPwIAu9opvQ
	(envelope-from <linux-pm+bounces-41798-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 20:27:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A38BE204
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF36F3020450
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83610387342;
	Fri, 30 Jan 2026 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJuLSw1x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027337F102
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801136; cv=none; b=SL577JBSCob9PofU6OWHBCISmfxkUJNtYjymmmcL19yxehr1wqrU9tcGmknEeRJytgjxfxjbDJQoCqYnwaLvFGIgIaFKxb3X2zm4pRqCG/ildr2AolD95kESnqQYDOk4FlIOOe+GXsj8TORqBWUl1BAEzLL51LnbxEh9tnxs7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801136; c=relaxed/simple;
	bh=iRNU6ULF3xAFYTTUcATMkWcKCARg5LR7oiCdEr4qq5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lbkgm1et4PF8mhwXfBbqiRbsPzcODFh2odFbnZyG2SXmQXCT/r+qObxUxI6g8q0xW692HUlxtgtWwjR6a1yX18942qnkySyTTcyYNqr8ThsLqE8kykz3U8Xzd5CWPl+jO9GIQ6cpTjmYa/7P28+hYAzjTjMhO7M4zApLMC0vB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJuLSw1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F72EC4AF09
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 19:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769801136;
	bh=iRNU6ULF3xAFYTTUcATMkWcKCARg5LR7oiCdEr4qq5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IJuLSw1xanby+V1WY1IU8bZflComKh6kPbWxVFHtWIYxAu++wiFlVQJ861YLTeEDO
	 1UIbjx8n/PsuRqyu08hLoq9Rn646PdNhtLIkWM55riUUOzrvux6oMHvyULYeHOA1ET
	 d0NQmsZU1AmjSBi7Lv+bCBhfu8Az9Lot8Azm5YHapJRJDrWoEne0ESl9+vWlDvJNfA
	 JErQaNgll8MwTJEd8fjE7IIQzyDu1s6lbCvQgUpBxGbmnxOSYpwVMJRFqWlFvPovl8
	 LTgJbC9HPqw2vvnjmUx0Bz+M7aVPl+YAFuJvM/K4CjI4FGdinmonEM7pmF752hO7o7
	 KMUKOIdrdht2g==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662f5c5507cso1415167eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:25:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCZEjiRGiLHVb9BFeg8FTHLuu5bf/r7nVe0oENOUr4sR4BEUL4XQXw8fb0gEyX6/75dNZYtlI/pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXU3tsZRaVv5gtEyJijCZ7XtQpzZX179s/0dtDIZsqb/OgF6up
	wUiaXIFRhmNcHBp01Z546oFq8uRu381F6EWp//HhJOe6A0VQY45DY/5I25IcEWx94VOiiiY+SEA
	Qt884YjVK49R0HWh/z4w2L0F+kevE0Ag=
X-Received: by 2002:a05:6820:c83:b0:65d:be3:3110 with SMTP id
 006d021491bc7-6630f04fa71mr2191742eaf.23.1769801135161; Fri, 30 Jan 2026
 11:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
In-Reply-To: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Jan 2026 20:25:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0javFwhhrmrTGq-DPUPK4-CEZtn48v5qcKstd+Zmw9X2w@mail.gmail.com>
X-Gm-Features: AZwV_QiqtG6SCI2DavyLoBekKA2NCIAxV--TO3berDthQYIbmY1ayv-n7dJ1f3k
Message-ID: <CAJZ5v0javFwhhrmrTGq-DPUPK4-CEZtn48v5qcKstd+Zmw9X2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix grammar and example code in Documentation.
To: Patrick Little <plittle@gmail.com>
Cc: Joseph Kogut <joseph.kogut@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,kernel.org,lwn.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-41798-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 96A38BE204
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:33=E2=80=AFPM Patrick Little <plittle@gmail.com>=
 wrote:
>
> I split these into:
>   Text updates
>   Example code updates
>
> If it would be better split more or differently, I'm happy to do that.
> These are strictly typo fixes, no clarification or rewording.
>
> ---
> Patrick Little (2):
>       Documentation: Fix typos
>       Documentation: Fix bug in example code snippet
>
>  Documentation/power/energy-model.rst     | 18 +++++++++---------
>  Documentation/scheduler/sched-energy.rst |  8 ++++----
>  2 files changed, 13 insertions(+), 13 deletions(-)
> ---

Both patches applied as 6.20/7.0 material under adjusted changelogs
(to indicate that they are related to energy model management).

Thanks!

