Return-Path: <linux-pm+bounces-43146-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNYmFnCxnWm5RAQAu9opvQ
	(envelope-from <linux-pm+bounces-43146-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 15:10:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D80F188349
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4428305FFC0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15D39E6D6;
	Tue, 24 Feb 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMIvaoMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD1369982
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942253; cv=pass; b=W8RnapmlptjoyiG0v7qGv7xVpJ+eWgLsOj46X+ag2OSj1PHqNKogJ4BQgcsC4ZOH6cvtWZehmUl3Bc2avVAiUQNeDV6q+I3HkCCREpTtJrsPWC8eKAuhoRbAbe9i0RuP1dvAdFHRBJiCbbA6gjXe1tcYEzhCOmKe+kKkODqEngg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942253; c=relaxed/simple;
	bh=hpsdorN+YUPPn7Xh8wqzg58+j51rmoWAuRENYhwmVv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1lXmwZKKZ6fT6RYVOw6XbRTkPJEGThPVGndyVYVE/WVHb7kJXK8LgaGeeJjWk/OF2S7+LvmoWngVFJpO2mxIfYjv4/bHaUQd///hTqr52smtqlcItgnC/ph0Ylpi6S8LN7SGP9Xh3rBMw7kBuE0243yPGhOpLghDlkPv07yjp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMIvaoMS; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3032653a91.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:10:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771942251; cv=none;
        d=google.com; s=arc-20240605;
        b=NbZzPncVdoFG56vpfbclQ/NFAboRQhSSnY2IV9p9Bcb9GTRsB0o1KGseIbvtnGZkR3
         3m+jjhjWaV/TKpYSuEBtUPM8IxFzv9ArRJsPfoHZ6scCM6MPIjGEkO0nBEefvtMkXxQa
         d2w7T9DVh/89NCxNWp/DhYMb8EAIFMwOWDCHf9ht4QT0M3b6Mm7S6fbKDLZGQEGclLlH
         3isDe7Dk5DwJtlQ2tiouXeaJQViV5UCbp9CxL86qYfNocInoUsnsChNe0BPRBIdvPpbB
         i7n+AiJ6OSMCuQSr+Gsbn2nP0bT2azwRvuk+BXjVM17+kJB9+ksrwgrTIhqyLWoIcq3c
         db2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wtM8qxcrND+YhwyhuCtWbAEEBm533DAJSz1s4D34ULg=;
        fh=3c2RvzOqRGTzjX2ubwnP6AOalPLmIw/SMSF9TpICPNk=;
        b=PxH5sZ9o+PqkeE3WGtsZo6cB0DAvag0ulL0Xq/gWlax+hQlTQV1a8zBGpli+s/wQ3T
         QnCrHVjw+QYam713PkmvRMxEg52eAA2Av3hYMmEgoKHkjjmOFsY1sYfR8CQ+Q/WLRRSu
         karbcgzIb587iwKYujGHgWBamFByZo4Qu9t/kP41CF2Ll63m3R9PVHX8IwpRFb6pFz8Q
         lXBmCvyTfnmnd39VGoC56qrut9kjL1BlwEQgj19oWRCsRjEZYCRirTcVAPayvOB6IKc6
         bXJfcFKyoNzEBdhu9VWvkjzuQ2ImHzFSOC+n2ZZldlr7uqtvKkVfOHAr059oiTjusC/D
         WcPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771942251; x=1772547051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtM8qxcrND+YhwyhuCtWbAEEBm533DAJSz1s4D34ULg=;
        b=nMIvaoMScGeluRzvRgiZpDTcSym+94zZuSaODFtGf8Nqx5JelVp3YcgWQimi1M0Lk0
         zCYmJbsluK2ktOBER5cpWderQA4z9zJsiF+DFm2NVjDIyY5VbFqptClG1dRJiJQgi9pa
         Y3+IhEDMdT/46/6eVrOTlSFZHjaqfZeHCASNe8xwrZqlWfsIAQ9/VKwl9b0JFxqcbZWL
         F4w0iqRUB9l9jHzTRyNWeLwKioJ/0KGy6PJWs0vYA1+DsFOB6lGoOaDKh/FwFRDkJsvD
         VFZZaT7tYOgP8kB5DZqCwtIXK/rwqI7/zYGqj028roCk82oZMz94QU7o3JGNWax8EWoL
         bXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771942251; x=1772547051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wtM8qxcrND+YhwyhuCtWbAEEBm533DAJSz1s4D34ULg=;
        b=D5+EDrbcaN/oLqwzy3QjOF3OH4y9n2Cc4EhEMzf/QgC2e209GiIbbQnUpaky1tY8ff
         KYZq4Vj64MtswPI6XCyfF6nbQJbl/Zn650Hb5j4RP+SDwTAgR0gMk+22thSouoVExMny
         JMO5QqYd32e/jNwunOQdpD9IkTzDkmEYAjZTSL36moEA413QJcph8f28u7xpL5lyGJo7
         agJ26ZgpqDHQiJK9+4ejX+XdV+1qQJTG5LfYvAmk65rwfgPQvXa+uSTcK4OplLlPqEYC
         b4IyjTCEWL0fkf9Rbs568O10vomzG6Rwe8PWfnCnDIQPr8DzSwF0rTS7dRAJ1fU8vMTw
         DYuw==
X-Forwarded-Encrypted: i=1; AJvYcCX6h0CohkerjtuJOn3++6/JOtMhdr8IfwLx0cVjdX4KfglHkPbpuvnIc9Sltb86UffoKRnQijqguQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdFK6MP4oKEAEo4Fg28A+3aK5nszacCd65Zw/dV1JFwepWSRt
	V3Rf1c5McMpm05Q3/K7OkbHX6/H47i6hAAcMn6/lz7o31t1yw8lGs6S0ved5PAI3QfuN9Ui0mRD
	gaB36/hzlFwJNs5Z1DWiW0la9Qas5aN8=
X-Gm-Gg: ATEYQzz0BnfLiZJeorYcmXkT3qCOqGhn/2RD/iMLZq1fNpYu3eGXRQ4/2Q0VkhY7tss
	v2Iop/QCX+9hGsTQT3e6BpgnrL8WPjlyCEPGClm0tC1afqIrzlmOZ8qu4XLEKAX3BrsYXMaylzT
	P/kLKMF4h9eo+3NveX8O4RTCaggrP/V0S+dDuLQr4+Dho+DQlntwYs1Ec3w8/p9Vcm+8777aiHA
	h6WvGRQgYmmSJ/nNauAPCJIMEookZzJ0F9MvWT0uJNFQIuJEA1nMuZti0dYA4c5aTGshqmrHfOi
	WBMC4g==
X-Received: by 2002:a17:90b:2cc7:b0:343:7714:4caa with SMTP id
 98e67ed59e1d1-358ae7ba72fmr10271715a91.3.1771942251444; Tue, 24 Feb 2026
 06:10:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224023719.65165-1-spevnev16@gmail.com> <c0979077-a229-4584-9ac3-747dfd96650a@amd.com>
In-Reply-To: <c0979077-a229-4584-9ac3-747dfd96650a@amd.com>
From: Serhii <spevnev16@gmail.com>
Date: Tue, 24 Feb 2026 09:10:37 -0500
X-Gm-Features: AaiRm51Kih3MHHxPNHZoQhRa3QH6GSxcy5yzM7e3mfX_e1NLe8FIEmbf__uF8HQ
Message-ID: <CAM_YkW65=Wam6or8KXdSdZFC2Q_XXqAfwREiomzH9+xgmFtERw@mail.gmail.com>
Subject: Re: [PATCH] tools/turbostat: fix microcode patch level reading for AMD/Hygon
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43146-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spevnev16@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D80F188349
X-Rspamd-Action: no action

Yes, the only essential change is shift.
However, I believe that handling the two paths separately is better
because (a) using different constants better highlights the semantic
difference of the values stored and (b) AMD currently reserves upper
bits, which could require handling in the future making separate paths
more appropriate.
What do you think, is it still better to merge back into a single path
with conditional shift for Intel?


On Mon, Feb 23, 2026 at 10:30=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> On 2/24/2026 8:07 AM, Serhii Pievniev wrote:
> > @@ -9139,7 +9150,7 @@ void process_cpuid()
> >       if (!quiet) {
> >               fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x=
 (%d:%d:%d)", family, model, stepping, family, model, stepping);
> >               if (ucode_patch_valid)
> > -                     fprintf(outf, " microcode 0x%x", (unsigned int)((=
ucode_patch >> 32) & 0xFFFFFFFF));
>
> Since "MSR_IA32_UCODE_REV" and "MSR_AMD64_PATCH_LEVEL" are the same,
> all that essentially changes is the shift.
>
> Can't we just 0 the shift for "authentic_amd || hygon_genuine"?
>
> > +                     fprintf(outf, " microcode 0x%llx", ucode_patch);
> >               fputc('\n', outf);
> >
> >               fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x=
%x\n", max_extended_level);
>
> --
> Thanks and Regards,
> Prateek
>

