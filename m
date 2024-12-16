Return-Path: <linux-pm+bounces-19335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBA69F38B8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 19:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D3318935D4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89521D45FC;
	Mon, 16 Dec 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="drxG7okG"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702777111;
	Mon, 16 Dec 2024 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372861; cv=none; b=edexEF1581iN+jbQnBJpmOnGtenFK0DGD8hAsg0ifk4ogZYGw6kz0ouLqvc/Ejg/0YpmCzjiaJIkr6EIM2asibENj+TFhQPDhZzChHsgtJq1QU0i6wlBDpRUuHZiylM8N2G2PwsitxGE27RuJjChq1h1mrAVrG8aRVE4h50yKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372861; c=relaxed/simple;
	bh=yEN55P156f8qs9Nur9EVhNSjfrz79ytrZwgY1q7n5Ww=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BxbqGX8Pm/DR4kbnly2G6s0a1Ui1HhJGPYK+W7KlGUpTGUdzP81YzYhkltOUnWaDK0G3SKomz2lMZH0/VonssxkyXT7mh3vmAA9in0SmMXhe2CoDgLX/Bfp+1RXDg/yIGIxcWRHSCQkTwhiHCMkjOud3QL10Na8WdWgPDgeTfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=drxG7okG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SjfNhuvGiolOyrjKsZTgRFX8OJYdur2afUKbQ/gvW4o=; b=drxG7okGe1i9XAqvE98rdkL0gK
	6VQceyOgk6MPOf4drANwU2q98fmfn1dEvTiTFWC4Q/Ou1nSK47fOv9uBDYQEMVq0lxa5khv8mq0kY
	S5Ba6HXcZMuv1w3OiUK1W+FWmj1dQ2bOSuUUkjCOe65fzrmAFQXNuutOD9kpE+RjLtudyDAyNmYeD
	iS0aLblPISiXb48W40Ht6LSGH0i9anIIPfEXsSbtvh7eFNN/7zQVIAm2OodCyuHC0cF5t7qeH+hhD
	b0TyLv5fCRtyslQ7DcOmQ5u+Hr6OlyWEvsZfEcUOfpWzMm/jIyTg04+DiyWEi+ud5zbSfV4HS6Wn4
	C+OeZxnw==;
Received: from [2a00:23ee:2908:bad:cd3a:995:e233:9fc1] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFbk-00000004vCP-0VOE;
	Mon, 16 Dec 2024 18:14:16 +0000
Date: Mon, 16 Dec 2024 18:14:17 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ming Lei <ming.lei@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: Does anyone actually use KEXEC_JUMP?
User-Agent: K-9 Mail for Android
In-Reply-To: <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
References: <4968818.GXAFRqVoOG@rjwysocki.net> <d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org> <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
Message-ID: <E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 16 December 2024 16:00:00 GMT, "Eric W=2E Biederman" <ebiederm@xmission=
=2Ecom> wrote:
>David Woodhouse <dwmw2@infradead=2Eorg> writes:
>
>> On Mon, 2024-12-16 at 14:39 +0100, Rafael J=2E Wysocki wrote:
>>> From: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>>>=20
>>> The KEXEC_JUMP flow is analogous to hibernation flows occurring
>>> before
>>> and after creating an image and before and after jumping from the
>>> restore kernel to the image one, which is why it uses the same device
>>> callbacks as those hibernation flows=2E
>>>=20
>>> Add comments explaining that to the code in question and update an
>>> existing comment in it which appears a bit out of context=2E
>>>=20
>>> No functional changes=2E
>>>=20
>>> Signed-off-by: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>>
>> Thanks=2E I'll round that up into my kexec-debug tree, which Ingo has
>> been taking into tip/x86/boot=2E Once I'm done fighting with
>> objtool(qv)=2E
>
>I have no objection to getting kexec jump more in sync with the
>rest of the power management code=2E
>
>I do have a question though=2E  Does anyone actually use kexec jump?
>
>It is fine if folks do, but I haven't actually heard of anyone using
>it=2E  If folks aren't using it, it might make sense to just use the fact
>that it is broken as a nudge to remove that option=2E
>
>Eric
>
>
>

It isn't broken=2E I know of it being used a few million times a week=2E

There are corner cases which have never worked right, like the callee putt=
ing a different return address for its next invocation, on the stack *above=
* the address it 'ret's to=2E Which since the first kjump patch has been th=
e first word of the page *after* the swap page (and is now fixed in my tree=
)=2E But fundamentally it *does* work=2E

I only started messing with it because I was working on relocate_kernel() =
and needed to write a test case for it; the fact that I know of it being us=
ed in production is actually just a coincidence=2E

