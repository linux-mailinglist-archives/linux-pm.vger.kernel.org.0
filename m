Return-Path: <linux-pm+bounces-36386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF64BECFA6
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FBC19A1242
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD42773E6;
	Sat, 18 Oct 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpn441VN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898311B4F1F
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791305; cv=none; b=m8W9SBti+Zo4Y7hgy7jd6OZC4V6mGIi9Q70vZJItKby9N8o3mYhLn39UarrX+Xb7fVmUPo17e4M/rl0U5/wbSdA4fxMGEAmPJ4Y+njx+PN4LNVdxNdcmCU8tuu2GJlydM5m+eDgWg26iVY3BMuGXg4NEdo0GWfWDRB3uv0nH4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791305; c=relaxed/simple;
	bh=o5/KluPyDYMIfPuQR1eQtRpQrDwQ7T9vUVmdxk9m9wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI5oxFhDGRU2R/ki61Z6082QyENfdHBmixKwsEN2xe5V9cHHGNHhDY/jo1dFHLDurykR2DeLKLddwm9mRLnozkY/MTyHK+QckSqpisOL3+NOCpSSpjrYFRP7fNRzsNgux1puZqwZr6HUvyA87NXiiIjJP6AhHlMRuHTFk9mIcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpn441VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D88C116B1
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760791305;
	bh=o5/KluPyDYMIfPuQR1eQtRpQrDwQ7T9vUVmdxk9m9wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qpn441VNTg2VtymDXh2X94PNXx3mvLqXXr01ZOQPqpUP7j61xawFZfzPE5eXQHUsP
	 hAeSauUNIkiWYIgG1f3hEHexG8OjtOgHbwNUwOqO4Ywxt0p1PMaItPDN46WjLnyjiy
	 oCqDRl7a3WkHmZTLszODKaGtrm/f/D6f6GNrEUyjkqkdJr7A4f1qLh1ZVfEY8xM44e
	 w3Ime5OEIxQigo51Y6gl6C2bj9NhS947XJW7JOPJpIFpwwIw+hWnuqYidpTq14WiKF
	 23jxccobsphmkcFE70b4YwAistGJ526jvt5BzTOiuvkLKKxWOTqt+x+nPsiHR0lVA9
	 x0pP/xoagGlLw==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c2846c961fso925035a34.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 05:41:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWk2fPVbKVaYPhyI/GTkwqscMwv2ttJ9lJmWcTT9CMzTpLDTnDrHAppgt+0nB1YN4a6/QCL6e7ygA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbu3f/qFQFCaZyp4iwo7R/iAAlIfZNOETheQiE0AOe/cD22xwR
	W1lO7acyXsGa77RjZVg6ZglkeuvSBXETFHzmDewmFH1i7wjh6vmHEtOm3tjj+5UlXCpLxks9FkE
	ucHRi8Hr5f/2yhaXeO4Ul/jcoX4ce/aQ=
X-Google-Smtp-Source: AGHT+IF65O7rOIYSYlXVS6Ib09prkwoOJViL4sucslIQQ1hqRL9pmkkrOdS9mEVlCSlY17xb7cT0eRyc8zQETZSzUo8=
X-Received: by 2002:a05:6808:1907:b0:438:1c76:d40 with SMTP id
 5614622812f47-443a2ee2568mr3275130b6e.4.1760791304507; Sat, 18 Oct 2025
 05:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013193028.89570-1-mrout@redhat.com> <20251014053608.pwlnexeh7mwjrvsc@lcpd911>
 <fdac8d84f266ba85d517542bdad0592bdc33b95d.camel@redhat.com>
In-Reply-To: <fdac8d84f266ba85d517542bdad0592bdc33b95d.camel@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 18 Oct 2025 14:41:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLCcCpiBqgQM=GcEAnQvZxgbtMy+bWGrWDQEikYOgC=Q@mail.gmail.com>
X-Gm-Features: AS18NWBhSRjY-f9IMuTmjtqqcA4jUMMI_QfRGQ6tJS1UDAc9Sk2pfDPrZAvpdNw
Message-ID: <CAJZ5v0iLCcCpiBqgQM=GcEAnQvZxgbtMy+bWGrWDQEikYOgC=Q@mail.gmail.com>
Subject: Re: [PATCH] PM: console: Fix memory allocation error handling in pm_vt_switch_required()
To: Lyude Paul <lyude@redhat.com>, Malaya Kumar Rout <mrout@redhat.com>
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org, malayarout91@gmail.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:54=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> On Tue, 2025-10-14 at 11:06 +0530, Dhruva Gole wrote:
> > Btw you can't include a R-by tag in the very first revision of the
> > patch. This needs to come from Lyude on a public mailing list and only
> > then can it be picked up.
>
> JFYI - I don't know how consistent this is across subsystems. I do usuall=
y
> post my R-bys on mailing lists, but it's not unheard of/unusual for folks=
 to
> pass R-bs through means other then mailing lists (like IRC).

IMV, they should be on a public record.

> Regardless, happy to post it again:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Patch applied as 6.19 material, thanks!

