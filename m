Return-Path: <linux-pm+bounces-42894-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Do8FkF6l2mlzAIAu9opvQ
	(envelope-from <linux-pm+bounces-42894-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 22:01:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6CD16282C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 22:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC094301B92D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920982F39BE;
	Thu, 19 Feb 2026 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZWfRvEQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C1155389
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534906; cv=none; b=uKaztt3w2DQysRrkIAJpmK4Z/nsXK7YOUynbryyk3hSP8iSx5tVSbKUXiCMtKItrTSHXQDtIGs7ruphjBZhjCrdUU/wKO/JG+ZqSP8JWfW1cFDKF69kpTmHWL6WbFEcg0AFwTej7/K2ynNOnygdCjmGqxBgucoi8C+ry93eIqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534906; c=relaxed/simple;
	bh=3wapsLc22ONFRxIRycJZzk7R5X/Jl+Q8VimnPKtX4Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chqq+wUo7y3mRnM/wFSPc7lMz7KNBGQl3hpbxsV5w2fi+0xlv6nCftKpaN9Yvbs2yB0DtmlcQBczmw8RZ/EXDdv5fFbxUSxwHi/Ru+XtgkLaAKsM7s7MGkUGmQJ5ouREQ6dgThYrhi8KJbCH7K/T9WXWEzNJwedVvXCSSV2P+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZWfRvEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115D2C116D0
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771534906;
	bh=3wapsLc22ONFRxIRycJZzk7R5X/Jl+Q8VimnPKtX4Qo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dZWfRvEQSnoKkP5BWRuq22jGRXlMys6xVa7+B0mWiAdHP1SjmtvMx/En7i5hFX0cf
	 +55AAdo6b2yCiSJfIWnBBkVHWjJVC7TNAvRBaAqIId+50eE0FJ4u6iTxuwK4gRY5Hw
	 oCsIbeag5ugzfFtNaIIDQeSBZF8dylW6Ug5sEmZf8rTNpZ3+GJDoxhS7leK/1W4ERl
	 rPZWRIerSYMfIdpkNNCXeYuF3UqYP9mKWDbJyHRSdu9YY7Pcw2Kemce72HWGNLIrOG
	 +V0JpoUQ2Mkj0G+wcDZlO06OVzvQR/GdOWq+ZkUEBGxOI4oXesmKFcATCYe+gMlBDb
	 Fs8wdbz05bL4Q==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1262253a34.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 13:01:45 -0800 (PST)
X-Gm-Message-State: AOJu0YxX5RaNfTkKhQBOMLTbcnl3j02zoBmx40MGXLESdi3IPXnzig2b
	veSAaB3iuHg5O909nbGoockOHBBBkA17WkSfJVStSxyNi6KcG+QjHxH8p6+VSOPAXfcqeYHfOHE
	8GHTglIaKAq9uY/cM/58Cx7uqqtVNK1o=
X-Received: by 2002:a05:6808:168a:b0:457:a9bc:dbe5 with SMTP id
 5614622812f47-463b40dacefmr9135659b6e.42.1771534905152; Thu, 19 Feb 2026
 13:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209124757.554032-1-ulf.hansson@linaro.org> <CAJZ5v0iZ0YS+JTMWAzmdUihgO3C5VT6Ch0UwzftskzaUqkzQ6Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iZ0YS+JTMWAzmdUihgO3C5VT6Ch0UwzftskzaUqkzQ6Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Feb 2026 22:01:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jFFXBUGjgveU=N4feMyQkQ45_1Rto6pYiPLjSO6WbSpw@mail.gmail.com>
X-Gm-Features: AaiRm52keu7IbEej1nW5XaCwGZuZ1oSoD6sXz4wEtwNFyQp-MBbZ5FcrzKdXIH4
Message-ID: <CAJZ5v0jFFXBUGjgveU=N4feMyQkQ45_1Rto6pYiPLjSO6WbSpw@mail.gmail.com>
Subject: Re: [GIT PULL] pmdomain updates for v7.0
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42894-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E6CD16282C
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 1:17=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Feb 9, 2026 at 1:48=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > Hi Linus,
> >
> > Here's the pull-request with pmdomain updates for v7.0. Details about t=
he
> > highlights are as usual found in the signed tag.
> >
> > Please pull this in!
>
> This hasn't been merged so far AFAICS, so I'm wondering if it has
> fallen through cracks.
>
> My particular vested interest in it is that it updates the last piece
> of code preventing pm_runtime_put() from being turned into a void
> function.

In the meantime, it has been pointed out to me that this was not
merged due to a problem with the MMC pull request, also from Ulf.
Sorry for the noise.

