Return-Path: <linux-pm+bounces-21543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D6A2C633
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55F2163F06
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0314C238D27;
	Fri,  7 Feb 2025 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIpoGQsZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8D238D20;
	Fri,  7 Feb 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939937; cv=none; b=ikTjC5+DjojcYjN8VOkkUWexJkL2TAvmhGO13UQ+DBv4FRIdbI73hWITuEtZEoi9NV+magJAnF22X2TeXUbV8yOht/qBVdBXXpfcCmhBugLtsDTeuv4jUBFdTcgEFHgvTZ6nG3n1FXyCQtqN/1SoVkBquxjxDqBjF/ksPGBvTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939937; c=relaxed/simple;
	bh=IGiibqfIMccHvyId4qwIytHUJSe5PzuOIYOLfhIzKTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7vTZOogfBshGO2eIyHrfTU8dWSk++V/SjlHr7XsUWJ6HCi6p7pGxun7ZuVo+4JzuligqSB/4n0GCuo/J8ZtRFZGSl7pFkHf52wpTRPb7cQHy9Qzb7hYkquWZrXB3kMWFFhMJwa92AL/sAIgAqO+kfiDqmNuZyFuCLS91+sWrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIpoGQsZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so3437440a12.0;
        Fri, 07 Feb 2025 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738939934; x=1739544734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGiibqfIMccHvyId4qwIytHUJSe5PzuOIYOLfhIzKTQ=;
        b=AIpoGQsZ3A8LBmtCcTZkNMI8XUHQ+L1cBCv5z1LgWP9Ci25PgXbPo/kM5fJ30bzvtc
         6+5oyxP0qrlIDg9xxWGOooxpcMkrJXylvgvQ8LiLGcM0Ey33f4bfv4iC2AzupRuCJePz
         qObvjUr5DmSs5D/nt/7WsevVg3eNm5v25G6GIPxaQM1raiCOGuKYLi+TO0rlCpIbP99o
         WaxdrKAaCKeyrkJaveM6EI3VK+esSuS9af47lbcEurgHTnF0bML7Th0elRLmzpA3U7pe
         bUPkDoUaYtJAiqddFXm3BPteoMj5dXc/LpHpnHdveGEdXnqbaF38mDMSuTxWbGPaRM1e
         xZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738939934; x=1739544734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGiibqfIMccHvyId4qwIytHUJSe5PzuOIYOLfhIzKTQ=;
        b=SGBY4QYWYNIbBS6EMHBqqzZLpbD0iysK3lkuGoNpoRCJ7P5GDYHt+olNpNtpD5z4EH
         Z8JVIhMoL1G0yz4dhT2qRq1wOsgEXvH4r63aaXD77kMTiHxUxFiyFePnxxgQ13QevrH6
         t6wsbMdg6JR8qdNcCp0Ts+8XsdHRuqjVvOx28B3zjj6pIjZHLdN+EBoRNTO9gXVmdiZB
         aNVaPvzEGv8KZqlOr1AL8jU5iOKa/4jWhRc9c9C73qunLa0rcYJ5okLYqHzlGmSdlR3E
         NltP72OvLif+7T84mHGCr5MjVo71HqNJuZeGUFc309hZkze8KYRrFZ3WRdi17Di/1B5I
         iBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ooAC+e+vbKumMcuHq81WcCjIn/Gr9HpkTPZjUHg0iQVqd/r1CLdl+pG72+7AGQU15iscIfemMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGlEzZHm7UaIcfbnK5RtFah6hyMjatAKjotFe4werCNa4oJkI
	IoKgJ9zKjFkIi6Q3tYmRyEl53wAMS2EpDzAbLyORM11AaC5wVnYH6+KFXpWr
X-Gm-Gg: ASbGnctqstyc1BHb9PUWXVZ5Hw2Jn0/uCGJlvewoyi5sSdeY9l9XMpIULDI9ZeykE3x
	+6/JHWGQcq1mhbFjz/u9DyxDgbKbY7Gz0dEj+rTPd/8krfe0ZnlSAyRf9xLaO6mAg2smXGwGIyA
	yz8Y8JzkjjnXD4mT34g4GPGYMLcLo+2jXiX8rquFF8VV8Ee5eMuppr0pFcsJ2Drz/691l7LpcXr
	U0BvnwyaGkDiNKIXFcbzWUDfQw1cP0leLwXHP2TspEOoh7XL1Ws5C5PmrjUv5ZoL+XliisOi57+
	VweX3mDLpC6dPxIXMlKEgqokYriYh754CrX9VzQEyUzfPQ==
X-Google-Smtp-Source: AGHT+IGHj8Hy/1kfAVuhHL6uF2UyU0AfLUzuXn8Tm8yWbu0Icz8KAI/hDZmYJWs0+O+Fy+aQm5vZCQ==
X-Received: by 2002:a05:6402:1ecf:b0:5dc:796f:fc86 with SMTP id 4fb4d7f45d1cf-5de4501880amr9278179a12.16.1738939934211;
        Fri, 07 Feb 2025 06:52:14 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5142ba50sm486370a12.11.2025.02.07.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:52:13 -0800 (PST)
Message-ID: <bacc3a3f6066af7a6b96c48d4aff734a29819a24.camel@gmail.com>
Subject: Re: [PATCH v1] cpuidle: intel_idle: Update MAINTAINERS
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
Date: Fri, 07 Feb 2025 16:52:11 +0200
In-Reply-To: <2774831.mvXUDI8C0e@rjwysocki.net>
References: <2774831.mvXUDI8C0e@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 20:45 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Update the intel_idle record in MAINTAINERS to reflect the current
> state of affairs.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0MAINTAINERS |=C2=A0=C2=A0=C2=A0 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11675,8 +11675,9 @@
> =C2=A0F: drivers/crypto/intel/iaa/*
> =C2=A0
> =C2=A0INTEL IDLE DRIVER
> -M: Jacob Pan <jacob.jun.pan@linux.intel.com>
> -M: Len Brown <lenb@kernel.org>
> +M: Rafael J. Wysocki <rafael@kernel.org>
> +R: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Could you please also add:

M: Artem Bityutskiy <dedekind1@gmail.com>

So that there are 2 e-mail addresses? Thanks!

