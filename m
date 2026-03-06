Return-Path: <linux-pm+bounces-43733-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AElbFVA+qmnGNwEAu9opvQ
	(envelope-from <linux-pm+bounces-43733-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:39:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3221AA6D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02EFB3041A66
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CDC352FAF;
	Fri,  6 Mar 2026 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0WnyHUM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12818351C2E
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764747; cv=pass; b=kWGZpt0UFhfVkBMORXvzuG7ws6UCMWuO8T3ihyy9FD+uoCcyW02dns7ZrgHmrAYtyxjrw5S0pFwUVY5rRZZPJwoNJhDDTmfv/+wTdkWdUf0cL6gE+xUOJNEzP5NScxOtXlVI5u/ysp/Utp6gkhUF4T7OFho3QkaFsw+KKLL8BQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764747; c=relaxed/simple;
	bh=ntNhpeJKHj9Gcz76mVeBjjXdVPDLd/l3flMVyUPRa+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJSBfDVAdzgA4lmePnHJuWEQEnX3taWjvzd6SM+UmtkzYU2gLLJBJp0LK5UofMrpbLhMLatcwoN5HpswnKRz3132ounP6H18QPqvj+9/WUlF4EOUH3K3hRvIG3WOTsUBKulSyagqjJhs8CfmP4v7W3TaRtKsjz8zQtDpDjJixU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0WnyHUM; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a3225d59fso21324671fa.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 18:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772764744; cv=none;
        d=google.com; s=arc-20240605;
        b=MMXuXkX8G1l/jfcWwfaPe++kIERDVK2HPpkSE8bj1bF2ZMMjBBqwutB8uwnsXq4FpT
         zqC/HmtAe+E91QlMBgzt5sTchll3lOFjbOJ4KYYpi6RHa51dhKrv1NKhtQtY19rWTGjp
         ZOVzwX4pUjIa/d0uZBGsZclngDuoiY1Nb9O05AjnkX+ryJmw+IpzlsscjxKgJrBX/t8u
         N9B9LnBfwGCyHmlAUbOL79bUB2NeGgmRuCUi71d+FVnOc6ylXVatIE7KHL7poOJ3ka5H
         gcqMWK3V0luLDhDKB//DSpUjqoaXSxdy0W35+vrRBM05Wm2iyl5gaaNbyLluFX2uZy1t
         PNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ycJdScU7VQZBgNX8C+iWhq//vtAo4EZ9U6PbAPueQDA=;
        fh=UctMHW0rOrAIpdFISgfEKv7l7Zd1IehIn4kEeMvSeUk=;
        b=Lv7RKbK5u5d9FqeOD5E7C+bcjBHldJgHgSvfWE4xnfhmLWkvp1xjG8wBgdjh8xQjoc
         vMO3deB/CU/R7huwNVoq/GB5vsk9K/Xows1hVou3ZO3apVh+NAcxvoOMCwhAuLBhzOt9
         KQnLrHUuEHHjxADWd7mwtDEX2ZJvxZdvJwx4uMeNZqDqRa/RReYAyqli7DwsayArJz5I
         VRrVwASvbzOWW7gVIWpOh7BI7yon/Dl3AwkejqR0tCiLYGEHkqMawsF3AdIqGxKB2yqW
         eY1JwUkV2QRtZjPYwKpGHlygk/rI73oISoL9bFCjZRh5ulWauQ58C5l4uWfKeT4limMs
         ZiOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772764744; x=1773369544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycJdScU7VQZBgNX8C+iWhq//vtAo4EZ9U6PbAPueQDA=;
        b=M0WnyHUMMaDt5lsk38jX6ASC8QdBxr/eDAckBJjn2P62s1fnWfTS2AeVTgjQT8Hxnu
         9u5riaPHF5Co2ynsFsF7kP9l9G+P8pOjvkqtvNjbz6FjZs/bY6FNgqwVi6kvdS3UQJ1y
         opgA1JQaW3qG1xRnDzHVy4vCb05jjg69HrNgkmdYVVf25XVhK7hQ63bO7kwwrecR9qMx
         nMq1qY1gWxR/M0YciIRSwO2+DD47BO1i5cEwc9pumvFX0Gl0oSVwCb3G2VoqgNuDx1uo
         8I8XWoWlOu7i2veweuZoustWDxQtdmzorBGc/TomL/fH1pONAWxNgLqra+qvfoSwbKHW
         Vsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772764744; x=1773369544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycJdScU7VQZBgNX8C+iWhq//vtAo4EZ9U6PbAPueQDA=;
        b=Num/yKptYlRkNqf/bxCRCplKSVgCavLHlWRxrYoqF8NGpYKYqw/vwYrw9IbzVB+/o7
         qVDXmV1ZpilS6hx0aigXoJoZcEcqxZr4ivgGGAO9vPROvr4aEvC3ogDQumHtudJd49wg
         FHqNOkgU7KvvDlk7+yfyHC9n/VtxpT8DdZgBc0S5pN1riR2A+JnsJGpZH6T1NrRO6sBp
         JXJ1Ut6hUZuUcUcK4Cy+5d7c7V/xUTqWxojAzAYw+1HiUYQw7t73cJB6RQNE5FoA1Yia
         nriB21W8TWICzmnVjc46H+iUXksgwxupZS8+GnS+8KnJ65zKZNXPyribl5baZlr1UEI1
         xtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcqv+jx3uCX/Iw610qZlueq67H6CILeNCqJh89EsE11xBDyDIC+x8AtpvdS2UTnOTlyZ9dI9Ys5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrxbi/jpFZEyVw8N/HLLaj7eTmoEYqd390yl6n5j0EDXZKHNF
	njJnNw9muS0CiE7ZLsoGeO0i8YHRRuS021b6hbN2QX05UJScFKPeqHHKJ9byR2pY9YJqs9VHP+Q
	kZab+fQRlhcXUWfDRS5a7tl2G7Xtfrg8=
X-Gm-Gg: ATEYQzzKpXMShBwiT32XTgU/OfecIg0GEJ1dt/I+qv9GNSCw4EKNxi1/d/7Dz4DFla0
	CBNS5FFweDF+/anLfUmS1UvGXYjGI1b/QpilgbByDL4BPVBn+eShLl+5lhEBT+fLFLUhD5gzcJK
	ElVvxptBQR3incRPrZRrGIUJnXjb+iTDrfO0LCZ9KYNiyAjzhnbtiCeatujUYBNMtJLBdXYZyli
	egoVOYT1xeoAjn/H/NuTWafhL9NKsTf9RyqoBNL4K4g7nliReJiwIi0mwCgAI6prLAMwsyy491T
	1/iaoiOSIRJJg6GIAbOnF+mcrgN8d6oLxzZ/My+pPlpOYQ5tjvVCjdPWk4oLEl2LQLnQ3cJl
X-Received: by 2002:a2e:be23:0:b0:385:c13b:5584 with SMTP id
 38308e7fff4ca-38a40d6e2a7mr1475161fa.36.1772764743976; Thu, 05 Mar 2026
 18:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306022406.760-1-ming.qian@oss.nxp.com>
In-Reply-To: <20260306022406.760-1-ming.qian@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Mar 2026 23:38:52 -0300
X-Gm-Features: AaiRm52GfF-aVTbn8TmD62YiOKnhcu-hzGhY6Qwg2C8seTj5WNPRzZ_mAb4wZdE
Message-ID: <CAOMZO5BP2aLD+a1r7hVd3F4Qvfovxb8PgQfzcVRKknBHWYBmtg@mail.gmail.com>
Subject: Re: [PATCH v3] media: verisilicon: Fix kernel panic due to
 __initconst misuse
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	nicolas@ndufresne.ca, benjamin.gaignard@collabora.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, m.felsch@pengutronix.de, 
	fra.schnyder@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de, 
	Frank.li@nxp.com, peng.fan@nxp.com, eagle.zhou@nxp.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5A3221AA6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43733-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 11:26=E2=80=AFPM <ming.qian@oss.nxp.com> wrote:

> -       { /* sentinel */ }
> +       { /* sentinel */ },

Drop this change. It is unrelated.

