Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176F48267A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 22:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfHEU5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 16:57:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43772 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfHEU5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 16:57:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so29924722pld.10
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=9X2wQUGD6zLRbLMDjJdPs/T0gS5tBwgXYnxhEUgwlZs=;
        b=C4qI1sqY5cPtC8702dZsoxLBKBli0n5d9Z9O2vEYh2ertxbu6hUXjIjZKClqm+PzXK
         /u4wPgoxWn7MxlkmuFAQ3VKGQT7BRUf0qo3hsFSr3qOc+U94xB1yilPpxop7lrME1vQW
         J92InGoXV9qe8Wetff/eGKJZJaXNkOX9al4t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=9X2wQUGD6zLRbLMDjJdPs/T0gS5tBwgXYnxhEUgwlZs=;
        b=um4AlYR1/nS+puvyKtMAp4vCox/QaRF8ZIOtHUjpz62bzyyqXXejyBvztTTuianJAx
         f58244kfJRP8wKd+KoH+kHd5+OPwK8zViqdnn22G5jVkB1s5rFfR+e6hcgsAfACW+YIX
         Tl3uQ/o2tP7mgyFNcPj4h4AZ2rVI1bmoTAa9Lf68hWVv4x8glY6XCsDYO3LpSS+ozHP2
         2dlHJPNOc9In5ODF7r/OEHHIV+FRkjdBFpUz50vRV1F2T+4XkfFLZ7tR/3xMgCT5IFpx
         97DYFb9flsMeQuNd5dh56DTkDw6IPFxjUm0CKHaTKkW/cW+Upary3NTXQRD38H9P5k0m
         /ztw==
X-Gm-Message-State: APjAAAUYHjVixYsnC2QRqjlUwZciCqVjTzL5F7L6OWdVQnNc4f7T4Hd4
        tvpJ/aPQv7dBoHR/Iht9icGdNg==
X-Google-Smtp-Source: APXvYqyTOTWg3ZIKAIS+XbhN0FVRmCiUQ/gsBS+nyo3j37myD1T7jPeK+PByrLv5icEaniJu39f//w==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr145799271ply.170.1565038667796;
        Mon, 05 Aug 2019 13:57:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d8sm78607456pgh.45.2019.08.05.13.57.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 13:57:47 -0700 (PDT)
Message-ID: <5d48984b.1c69fb81.325a7.e2d9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805175848.163558-3-trong@android.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-3-trong@android.com>
Subject: Re: [PATCH v7 2/3] PM / wakeup: Use wakeup_source_register() in wakelock.c
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, Tri Vo <trong@android.com>
To:     Tri Vo <trong@android.com>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 13:57:46 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-05 10:58:47)
> kernel/power/wakelock.c duplicates wakeup source creation and
> registration code from drivers/base/power/wakeup.c.
>=20
> Change struct wakelock's wakeup source to a pointer and use
> wakeup_source_register() function to create and register said wakeup
> source. Use wakeup_source_unregister() on cleanup path.
>=20
> Signed-off-by: Tri Vo <trong@android.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

