Return-Path: <linux-pm+bounces-42808-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGGBJQR3lWlwRwIAu9opvQ
	(envelope-from <linux-pm+bounces-42808-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:23:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11469153FD6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF3B3307752F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205B31ED94;
	Wed, 18 Feb 2026 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COO7DNZy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4F3191AF
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402929; cv=pass; b=GZPQ85jq8+mmAC1fpL25p5HOCYVAdIhg1DmeRr6Zs1sVV4RM7FrkcuIfLkwyEJousk5yMRemC7gaQv8mLlwstm3MztogIM8Op6HOhy1uGs/RAS6T6RFKppVZ0c5bRpLSCJ0zunZHMEZ75Q/r/YzLhQyM7f77oA2It2nEH5ykzMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402929; c=relaxed/simple;
	bh=ANNLtJ9GzlWB0Xup1M4vIFqZ4PNKiRYdjkqc0gF+j9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0bQqZsJo9/mf4zBr0sEceH1I1dcc6D0f6NN3p5XfM95tAR6nH0KfqSEkyk8YGYhUqgMvj0lVMtAZSqApneteJv6mLE+qzMaKC7Fkv+Xo0p0Do3LTF+jqHz7UOwRt0UHZ32XAFEtPLF3S5tY/p0tGkxgTEn1783mYH32vqGaX3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COO7DNZy; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-896fd2c5337so42224306d6.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 00:22:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771402927; cv=none;
        d=google.com; s=arc-20240605;
        b=TrW901pFPfMJNZhMaUUay0PE/q9QtfklxNJK+kFJSL4wN9WxMoD8+yjx6Rhm1LKwfj
         VwL4CFqsdMhn+VQiCs5Ofz4muHXNwSt6KryMQFPeDzWlktOnTBcOhKio/BTbwMS/sFoy
         qH+WHoICdTEO29mOwpVsqI+rWUeFtpRayPsAiclOtXw6RG/xi4Zt2kGr3eQypxobzfEK
         mJHnFzIovZtmW7jK5Sab8JM81YPnH/hEYqAf45rTteN8o6/Ast1GX0PqbvEtgMfTpLgp
         BXtswMDDj1Vxi56IgDfH9FW37KOOOMgO4Pi9RK/e/GZ7msLZN0Tsqu3W0ecYQVaP2EO2
         RpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0VwAoqmz66WeIU23esW8xdZMDlNsUNI3Eyt5WAil5ec=;
        fh=IKiQHxZxbuX6SY72uo0OVCM+kcLf8/a6fVBm1XBHt5I=;
        b=QffGJZpbFOe2Y8evl0h3JSg2mQu2NniXg2xBRT8hewLIjLoM1BB6JDG+9J/VI3gMKP
         PVSNuqxdHXJEdBccmEkGrhy8aPmt9g30xiHWRic5bddGD97QGAAfa3IS4CH6/nqN26Q8
         Zqy+Ynal6sywWfMN7ofs/djWwZq6eP/scmHQwwSdFE6VhvCcuha9TgxY0XFSNcd43UPM
         q0N6g2KD9LnhVUjCYl2gnlCxulLwqBjn1fo/quW8lGl6xEU2PMVN2XjWtrRipk2VdmLx
         MBX/wd1SlcsRaLqLP8NZ2IUwKSnXzX9F73UNr+AECEyA7eLmCQBtAf61LMu+HBfMnpGM
         3FlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771402927; x=1772007727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VwAoqmz66WeIU23esW8xdZMDlNsUNI3Eyt5WAil5ec=;
        b=COO7DNZyzJd7ZC/Ab3JReWrDg8Or97TAT6etBfI1nJcx7up9kPAJjb9P786nBYjr1s
         Y/vwoXZIYBmkQUlA2a5tI0xjr+QyAwwLpehLOVj9C8FZYHd06J1Vj0PJErPqG2Th/JgX
         y4+pRsKqYNrC1UxP9KzgHSkzS8VfSUMZHQmnGe9TFSjVYXqNJaV6H1EiLQQ3ideweSQ/
         LB7XH1Jxde89Ff4Y5H/yDGN60pdK3OAUq5l0YwC5U0hz9DD5Wfm+kIjmZCb+cSdcl1sr
         G/ZhsiG2voarxszeTgv/E7Jn+i/3Hsg7o7Z/HIkFdKMs7S1QzSnyYMHM8cqiE0oq/FZb
         nhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402927; x=1772007727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VwAoqmz66WeIU23esW8xdZMDlNsUNI3Eyt5WAil5ec=;
        b=iW+U8biigp1gOQ5CVNeO0Emzt5fVn4i5n2p8urphtR8tWYVSKW92EVaf+1ijF12zW8
         NNHh9m8kmDfEGI9fYp1YPvcmpsm2nbmkgeGLhqusFNskRA/e+VfQLv8oPGXRVUSJrxQw
         9T1B/s9XMj1FVMLiv68ex5khgCr0td+dWbWNgLKFSIyYr/4VOYXioLL5fecYiEdzrZ0m
         pYxFqxHOXQWtIdgURpX4CEss6t10A+wJzMMCjBK0gUpgyFQ4jHc+FP3zbQiDtN41ibcp
         8CRsdgEhwNOgzAaKzmaXVAO0ej+60Dv9iZdogUZITIYoEoxGmASI0RYKq+QVOUSvDLOo
         JVNg==
X-Forwarded-Encrypted: i=1; AJvYcCXPrV6MG55zLV/HUSNXEuo26YLN0SEhd1jb8fTAOC5ViRLD+5HTze5lDr3//J5IAkfs3RKBFRiS+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YydXAG2ej2Tikk4glJYgh3ZjTJW+DFNtJ+uQHHYwyRXevU32knV
	PsxdWAKSeaMcrVjdf4hmyZIww6hTfIExJw0Cl0tJaUzH+ncvrlTvxgBvWXPPArKnpeLFuO4Rp3h
	V3NQH/DlYw09ewDYJSSgku4pes1NgFCk=
X-Gm-Gg: AZuq6aIrV7omJT7/BgQkIXzkvvJ3BS0Lmuriu5n4Kp7RvlmsKmjlZyrtkHxZgKvDsrU
	eTXXaEo4fmlV8IO/hRIYa1DlGm7x1KsNrREcuxP4ueX9mHqNeZ3EvEKVSR5siT6DVjRHypn+jNy
	vUF323JPe1E4HqVWFU3L2HQb+KKNnkxRACB9xVlzCiYHK+7LwSnXFB4Dhr433x+cyIgEI9uiLio
	lkkSTMSFwY27O+o+DiwNP/v63oLLPohExmyxYP6EyIxxrg8N2qCf7MUYrGfz0k13vsDXC2ZeR8U
	u7dpPQ==
X-Received: by 2002:a05:6214:1c85:b0:896:f910:c906 with SMTP id
 6a1803df08f44-8995811af93mr11500986d6.66.1771402926552; Wed, 18 Feb 2026
 00:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com> <20260216-hibernate-perf-v4-2-1ba9f0bf1ec9@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v4-2-1ba9f0bf1ec9@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 18 Feb 2026 16:21:55 +0800
X-Gm-Features: AaiRm53oR7JEByBnQ7WayK0ocGjk6XfMhYuZuHIES33oMMJ7Hockf9ku4FZ0lhQ
Message-ID: <CAGsJ_4z83AvzDNXFOY7UftOAkPcK+6AoR2rE_2rzQLTqx400eA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm, swap: reduce indention for hibernate
 allocation helper
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42808-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 11469153FD6
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:58=E2=80=AFPM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
[...]
> +       /* Return empty entry if device is not usable (swapoff or full) *=
/

I feel like swap full only affects the swap_avail_head /
swap_available list. Does it also make
get_swap_device_info() return false?

> +       if (!si || !get_swap_device_info(si))
> +               return entry;

Best Regards
Barry

