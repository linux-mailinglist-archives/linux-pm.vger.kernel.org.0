Return-Path: <linux-pm+bounces-8610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DD8FC146
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E1EB24528
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF1EAFA;
	Wed,  5 Jun 2024 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b="tt+FT3lL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AEBD266
	for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2024 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550891; cv=none; b=BaggXCTM9lM7QsTSg7614i3mEKHAbnps2+V1scFo5u4Wf9MrfgQutu5J7u6LMJdGzsqmXKavoIsHGrO2VkgTD0fmVjAEMRErTlwxoM+C2zTIwVZbu4yDVkPbub+tMxzD9sPXOdjZFNjp3AONfxc2eEMKJM7PpGKBs7J9ubaCTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550891; c=relaxed/simple;
	bh=1aAtN/3z/CC+KoX4/Uc468gsc1Odb+4pk0TbWNTH5rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLvtDaZCabK4LK7sFYXejZghHTWuSKCHTh/rBA/ez7K//Zn+G2rGAdsgUyv3ITiIi92JY15JaHksBwzMZ2qyiUCdom3W8JAErDy9V9otLnV67lSS3pB270tKnUQSBx+9E2ElFsqVdPDoujNh/mYikuKTln8z9Bl4lq5oH+dxAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b=tt+FT3lL; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa7fafa0c0so388297276.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 18:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20230601.gappssmtp.com; s=20230601; t=1717550889; x=1718155689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aAtN/3z/CC+KoX4/Uc468gsc1Odb+4pk0TbWNTH5rk=;
        b=tt+FT3lLTJnj8aN+o0+xOkQN/JTcTWZWIjXbRRUlHf8Kr8jVb8sdC5FgSH2wPr9qU6
         381P/7uuhx3VU8IpbzRyy+x+sC7vIGyaq4YI89Oo+XqNuY1b1QbjlkvqcLtlO52+KjTu
         X8zeWgbUqqy1fg3h41yXtLHC/AH1E71YWG3FbgRTltc7wZtE0atG3CeDFruc1tJTQTfG
         PZSGhc51KhJgF1VGI17A/3IBhilLEjbnXg1QYmEPnJFM35BuK0sQ+N5n1sOfw+CxINZo
         MjGNYklVk5Ega603pbts7+IF1WQxVkdsdp/9uEsXZnIDgjaKSfFZspGy8EVe3UeysmLS
         NIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717550889; x=1718155689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aAtN/3z/CC+KoX4/Uc468gsc1Odb+4pk0TbWNTH5rk=;
        b=koXqnxkHn+wNpy72gRaILMqaD0WAYdARR89JBRyqX0C8xHNIq7soTdPw0OaU/4C1p2
         CkNIzo1a74+OtlIALOTIS/IC4jT+fnjI1pjk/R3+Gssc3G7VS3IZ7nlhT8UY0eNDHT03
         7GEKpf7LV0vY8vPzAofVyYbDW9GitK2Q9foj7o2y8X+dZSq2b4LFK+EHHJyaXNb1C911
         LHjmwANlthyKy5ItiJysNTX3zKTk5Si522jv96HZ2bk19FWQEnObjqSEIMDH31NI1K9/
         CQFOx3L/b1U6tYn5z5ov7eb7e87y4nCY3RW78OavOJi7OE2g286RabcEb3TyBTnRiBKT
         qDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSbGH4tGxUDEeRu5LkqlzfqIJZb07xuAh/wlibjYk2HylhuPYuw2LG2fybanJPVXRZp/rLTcNSyeBd8wxn3giCEh1YlzKe1Fc=
X-Gm-Message-State: AOJu0YxoNMav5KJ2IcqL8kKXJrsjFReiomFjnjEQTfH6vxbwCahVZLzW
	jEiZRt7AUh5bXjSVDx8hN3r/mGry0/MPAXbe17D4DYR5CwbWrpDOQaxbDfRYLwkjiBsS/bNRKQL
	1w1EWFrfh13lHzpt7+pQWbcT3UQy0CGfe44gI
X-Google-Smtp-Source: AGHT+IH5b1wkP6S8DAEsGopYfUuPnn0CZWaw+8yynTwvbj2MBk6B92RfrPC2tnzyTU88t/RNBKA5stTuHDy5P/ggUWk=
X-Received: by 2002:a25:bcc6:0:b0:df7:92ed:365e with SMTP id
 3f1490d57ef6-dfac97ce463mr1085810276.26.1717550888977; Tue, 04 Jun 2024
 18:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com> <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
In-Reply-To: <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
From: Dustin Howett <dustin@howett.net>
Date: Tue, 4 Jun 2024 20:27:57 -0500
Message-ID: <CA+BfgN+LE3YyF3te4m8sWbtH85tU+ERUDW7YR_BFecusVTAWWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:59=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Can you try disabling all of the Framework-specific charge control
> settings and test again?
> Probably the different, disparate logics in the Framework ECs are
> conflicting with each other.

Fascinating! This board does indeed support charge limiting through
both interfaces. It looks like the most recently set one wins for a
time.

The UEFI setup utility only sets the framework-specific charge limit value.

We should probably find some way to converge them, for all of the
supported Framework Laptop programs.

> Thomas

