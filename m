Return-Path: <linux-pm+bounces-36968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B0C14AE9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C3FE4E2448
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB832ABCA;
	Tue, 28 Oct 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rRgWkh1K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFRK34vH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rRgWkh1K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFRK34vH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D981DE8AD
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655643; cv=none; b=T9Wp58c6NM7ttPmnrvGxmY09btqz9udcE0JqqAW/YJwbNwkHAM69uFJI390yoj6zm2kfEly1QsLvKmFX/ZDs064ssS7f6nbH4SX3G86ujlvGW3iOT2xozqOciItxt6GF7CJvD8lthbPgoulVWv65tYp59jkZAzIT2SDHwQ4HhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655643; c=relaxed/simple;
	bh=zn9QZORGnxY6ZMGmX6uLDnK9b7fOAtb7CHTU2diKlgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NtY1+oD3gPALEbg/Y0UGV4DkBcNU5t6/HgEYLf7fux0gYN8/MaTJVQeCtNUodsEFl7WHwlZGEuYqlXOqJepEDALaoVa/KyH8H0Trc/EQgqEgY7AzN3iH02RcDHOVVZOI24osdtNQo/R7CqTpoUCNpqDPdZxZVwDDwttHrhYCX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rRgWkh1K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFRK34vH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rRgWkh1K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFRK34vH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C383D21A3A;
	Tue, 28 Oct 2025 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761655638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D+8TRGN0i89jYErkfhVPoqDYXLalGCookKILuXZeFmo=;
	b=rRgWkh1KOl7OnUL/1EFG6IvaJdt+K5d1GCYodvC4ZUHmGdfsrdWWQ7MT0xE4PHAYA7QAir
	Xtyt+uIu5us90a5pllyk5WL3pi9tJKNKUA+DmtJQpqhjVvNJTa3kMzAfPIgSZHvpnyCauX
	7CoPkiXoqOPULO+tSxMEW1+zsVgQxy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761655638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D+8TRGN0i89jYErkfhVPoqDYXLalGCookKILuXZeFmo=;
	b=GFRK34vH50PL/Xc3tTYPFCDWkElJbqM3BYJIyhcRIRDd0pUQyUPXak5SvwugLJS8ILLOvL
	cMa6e83SZrd1X+CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rRgWkh1K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GFRK34vH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761655638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D+8TRGN0i89jYErkfhVPoqDYXLalGCookKILuXZeFmo=;
	b=rRgWkh1KOl7OnUL/1EFG6IvaJdt+K5d1GCYodvC4ZUHmGdfsrdWWQ7MT0xE4PHAYA7QAir
	Xtyt+uIu5us90a5pllyk5WL3pi9tJKNKUA+DmtJQpqhjVvNJTa3kMzAfPIgSZHvpnyCauX
	7CoPkiXoqOPULO+tSxMEW1+zsVgQxy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761655638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=D+8TRGN0i89jYErkfhVPoqDYXLalGCookKILuXZeFmo=;
	b=GFRK34vH50PL/Xc3tTYPFCDWkElJbqM3BYJIyhcRIRDd0pUQyUPXak5SvwugLJS8ILLOvL
	cMa6e83SZrd1X+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE3CD13693;
	Tue, 28 Oct 2025 12:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vE00KVa7AGmaOgAAD6G6ig
	(envelope-from <trenn@suse.de>); Tue, 28 Oct 2025 12:47:18 +0000
From: Thomas Renninger <trenn@suse.de>
To: srinivas.pandruvada@linux.intel.com
Cc: linux-pm@vger.kernel.org
Subject:
 Disabling  Intel turbo on non IDA featured processor generally correct?
Date: Tue, 28 Oct 2025 13:47:18 +0100
Message-ID: <2764104.vuYhMxLoTh@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4993414.OV4Wx5bFTl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: C383D21A3A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.58 / 50.00];
	BAYES_HAM(-2.97)[99.88%];
	SIGNED_PGP(-2.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,opensuse.org:url]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -5.58
X-Spam-Level: 

--nextPart4993414.OV4Wx5bFTl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Thomas Renninger <trenn@suse.de>
To: srinivas.pandruvada@linux.intel.com
Cc: linux-pm@vger.kernel.org
Date: Tue, 28 Oct 2025 13:47:18 +0100
Message-ID: <2764104.vuYhMxLoTh@localhost.localdomain>
MIME-Version: 1.0

Hello Srinivas,

Since patch:
ac4e04d9e378f5aa826c2406ad7871ae1b6a6fb9

there is a user reporting turbo not working, while it worked before and
he claims it works on Windows 11 as well.
No related BIOS option avail.

The patch mentions Skylake-X systems, while the user seem to have another CPU:
https://bugzilla.opensuse.org/show_bug.cgi?id=1252385

Can someone from Intel please double check.

Thanks,

           Thomas
--nextPart4993414.OV4Wx5bFTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEo0EXulPW3gW/5bAoTxjWwdl3vVUFAmkAu1YACgkQTxjWwdl3
vVW7bwgAt4qbJcbQXyEBqPLACcYHAgcuWVUMOcE5RZW4jSqNwyuEhqTJLKSrj3kn
AObR/SpWjXFRJbnAYiI/ILCHz59KS19gXd/GlPWUgACjqlQXPLNNGv8pTypHtGgi
EbQCAC2zc8aRjsA9uYDyBYYwRAARnKNip0kD21+1xvQ8HeV+SmjuessTqOMXv3dN
jAJwczA43YQzJvGygWXlKawH9rCQ4hmbVCKmRcBAs4Ka3CMAnskwU5m744R+H3yz
r8rOsie2ttpioEbJFuL1EZXtUsFFY76+kFk8frvsAh0uZTl+K0K8AB90mldbZ0xe
r4uf414XXcu9I2iZT78TY+2+AiiaXg==
=KuH0
-----END PGP SIGNATURE-----

--nextPart4993414.OV4Wx5bFTl--




