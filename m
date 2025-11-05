Return-Path: <linux-pm+bounces-37470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A75EC3632F
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76E154EF499
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD9931329D;
	Wed,  5 Nov 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JRnzehlv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/hqneUYy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="scPuO0Ty";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oat6Q9H7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A415248F57
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354527; cv=none; b=brMxYldCzfLRh3TwnO1KqzSNRtmNcdxfuHPCyCfx1ATayVdmRW9XAkaqqRJJSzCsc8a8PY+pkmF0xHLlU2lZubl6PP7xMAyISGpZeOdbIbXYmWQKMFdjtmK3kGZyEhu7QXRpbLbvZgY2KeF4lbDIDZS4OA0azqR96g2LomLGEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354527; c=relaxed/simple;
	bh=8kM8XjSBqrakd3ipAxKuiLcqN1EkJRNUvy59jMuUP0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=senqnkctGZ1eCw4OLRGMnbgqtAqT2n1w30RyWGJPUCL5VGA/x17l6q0eQd276DHmVJmOKsW22pdo6fKHsOb4CtP1bVI75SyK1ojhodQEMzdwzAHbqEszx/0i+xKTmdRiPD3farI3C+uW9y+94Vlmk7sfiPGuqKc2yNsDVgrrIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JRnzehlv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/hqneUYy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=scPuO0Ty; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oat6Q9H7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 59BA92117C;
	Wed,  5 Nov 2025 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762354524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JdB2tm3Uwm3dzKebg2BDrKnUG8tTSeNWJ9pLlQEBc=;
	b=JRnzehlvkXMlN9P3Xi1ljjnn62tBurw9dHrmRVnG1e4FsNXcy88VpvEks6qTVaBolmI2De
	0CghM87IuK8FsRcqKAbew4dZZPc3RDdDwyxj26ZQvdDBDAysOQtQrWYThaxE8lDKjKjHxO
	qYgKR+Gnjzd4/vN+sKgaTZi7IJMY99s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762354524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JdB2tm3Uwm3dzKebg2BDrKnUG8tTSeNWJ9pLlQEBc=;
	b=/hqneUYysDEXOS3r0wHCtRG9z8scQvpu7SQ46uOY9vnMQQTQyeGZoQGFNCgXRxT7zTV+Af
	vsUJQ+z/5TY34iAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762354523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JdB2tm3Uwm3dzKebg2BDrKnUG8tTSeNWJ9pLlQEBc=;
	b=scPuO0TyVdAB3oHQAZ1HmQj2qg6O0gCVL/uBIxz1DWylqIeOVqHzmdf10VJDDD9NvGRTwr
	6tH0754yEAO8WlqPE5Yb7jZdWDNtq+bIUPliAnY3nAUaNY6Y4iwGDQWc+HiN5VoZThQVCd
	Bah80uLRhuAdLqvFdRd1EiXz147GD3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762354523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JdB2tm3Uwm3dzKebg2BDrKnUG8tTSeNWJ9pLlQEBc=;
	b=oat6Q9H7TeapJzEoYZlXBANBDxcIUF/mdOMJf2wDFDxNZHqn/JysIqs42kbfEiko+rO5lZ
	iZm6X5Vtkb7rjwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ACD1132DD;
	Wed,  5 Nov 2025 14:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ixsiDVtlC2lnaAAAD6G6ig
	(envelope-from <trenn@suse.de>); Wed, 05 Nov 2025 14:55:23 +0000
From: Thomas Renninger <trenn@suse.de>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, ez2blost@yahoo.com
Subject:
 Re: Disabling  Intel turbo on non IDA featured processor generally correct?
Date: Wed, 05 Nov 2025 15:55:22 +0100
Message-ID: <5615342.jMkzrH9lRO@linux.fritz.box>
In-Reply-To: <356b1c77ef385158d062ad2ecebfa275dc663017.camel@linux.intel.com>
References:
 <2764104.vuYhMxLoTh@localhost.localdomain>
 <356b1c77ef385158d062ad2ecebfa275dc663017.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1829022.F6Skx1H6Bt";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Level: 
X-Spamd-Result: default: False [-5.40 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[yahoo.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -5.40

--nextPart1829022.F6Skx1H6Bt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Thomas Renninger <trenn@suse.de>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, ez2blost@yahoo.com
Date: Wed, 05 Nov 2025 15:55:22 +0100
Message-ID: <5615342.jMkzrH9lRO@linux.fritz.box>
MIME-Version: 1.0

On Mittwoch, 5. November 2025 14:06:42 Mitteleurop=C3=A4ische Normalzeit sr=
inivas=20
pandruvada wrote:
> Hi Thomas,
>=20
> The BIOS shipped with system disabled turbo on boot and user had to
> manually force via the sysfs. With the new change that is not an
> option.

User (adding EZ, sorry for missing you out on initial post)
claims that cpuid shows:
So I ran the cpuid commend and it returned:
Thermal and Power Management Features (6):
      digital thermometer                     =3D true
      Intel Turbo Boost Technology            =3D true
 ...

Not sure whether this really is the same bit and whether this is prove that=
=20
IDA feature bit has been switched by Linux OS (by SMI/firmware?) after=20
initializing?

IDA cpufeature bit is not set in /proc/cpuinfo

EZ probably can do the one or other msr read/write if you need someone test=
s.

Good luck,

         Thomas
>=20
> We are trying to contact the manufacturer, but no solution yet.

That is appreciated!
--nextPart1829022.F6Skx1H6Bt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA5FiEEo0EXulPW3gW/5bAoTxjWwdl3vVUFAmkLZVobFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEE8Y1sHZd71V9SYH/11miU+DAkhbB9gKTfQi
fsrgNn1ZKijxVfYhNB0Jn/4MO2dtDs6HcRhrqxXRzsUjtCfjBQojTwyvOg+FPO/i
V+Jl9/7WEWaJLu6fdI/BjdJ95Z8+TCSJOP+Q2wLmnxrwksV7j5LaedAyYgsqLYcN
td2O18iXkxV4haJihjqCN3fBza9dyUbKbHhH6INj43TtJF13NmQ3bWe4RxmC/DLH
1kxIyzVM+5O2Xy6u3GMflUKsT04YlzJFSYrRMqK+NYntAWicO8a9v0lrWWXNxHGL
7zg5cfuOYXH/OBWy3LlH8UFGGKaYeb1YFZh555SrihmlEvvTSldrbsajlXVOa2I7
tEU=
=ANKd
-----END PGP SIGNATURE-----

--nextPart1829022.F6Skx1H6Bt--




