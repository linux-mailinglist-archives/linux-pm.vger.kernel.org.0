Return-Path: <linux-pm+bounces-36611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF9BF96D7
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 02:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C30B19C47D1
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2B15E8B;
	Wed, 22 Oct 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArOB/JiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41BF507
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091671; cv=none; b=mKQckoJaoKh4uw4lA44PznjCzx9SKBBhjsGxImnYcFCtcSmkM9TizoTZtp2t/PL8qaYYvcT5uY9DxOwxUbN5Ot3pC+8+2oruuBRoJLJ3SysTB8JJMwW+jyDj6xGKpI6pOsCftfcWpR0cWUizrjtLL7BaLMr/3EdDSPjPaiNEqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091671; c=relaxed/simple;
	bh=m4rAzEVY+oK9Rlt9el+kLv1jai8azcglFs+lSP3+LP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUaaz7PJqG1eQRK3PeErbIstzbazzuT8uDbUi8/YY67pxB+h5Rc3wePUKly0ZYo1kjSUd6hiOYztHKkJ8L95hs7hLLqHE2lCg/ndQ9Q/S6Ly0FBFI9JxMin3QFylMU37ePp9OXx5brcljQ64zXWBkyAorz6zgQyarHVRocPJfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArOB/JiP; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-583a520bd81so2171099137.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761091668; x=1761696468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4rAzEVY+oK9Rlt9el+kLv1jai8azcglFs+lSP3+LP4=;
        b=ArOB/JiPpnduati9J80En2DfivPATFu7VtpXIZLMfBawihioB2cUnGQagP7ru8ErVr
         Uy/xJr+pOcmOiSrn6wMaDP2i9shhLeLG8OP4OECcQAq3tjs08NUG3yD1Rw1ja1z5k4Pd
         obHbX1FEGqs010XfLGFSHwbieKO+SUevDouPlVfTXiyYnIJ4u/rJJF8U4tsNWv1dvpiY
         K6SjW91ko9JwVBGU+FIZ2mNvzEnDO20+hOdYcTPta/aLc6THAV00m1rzwgCuZnMfflY7
         Wet9Tilu9N/ndtpHWjjyOaI2B/+ZPeW2IPbiJkue8FDY+tkXYwFiGrYorNkTxJpuebtf
         8uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761091668; x=1761696468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4rAzEVY+oK9Rlt9el+kLv1jai8azcglFs+lSP3+LP4=;
        b=sLhO/DEQnlaZ+gRxwzVkVHBeh2imKBbJFoPbGPYOdFhwp8/9lgRxlZApmrCtgrRfRq
         z2HVT9e2hJ8kayDS58SplgrIYlcIvsGhAny4OQsnTH6qVZWpIq/oyuTFcmHmjD56emqh
         lRu5CNSSgP/NyIfZVLKlWzYfSKrFK1x19ewFjSbF/JoIh8oclHj7+oV2O6zFdh6r5iUl
         qfhsg4WI0p3jLfv3AXGrlktj9ASNdlJyWZekSv1CQ3alZ9nMTuSb9JdN4HmajTtXMAdq
         sel+4KioWq1Nbo9r4E+H+j3LM5il2UbKiLX4LoDgkllFyL4YCY6UNw61U7xYDsJV0xCL
         aZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWDccaPRTPpa68LKM20yUZWgiCBRlKcBqyZFBWv8bk1wMK0qqJe7t/dso+HI+lpJXZQmKgAtE6etA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznBaGCISLP4ha9zGBlRvPrM42Db92KuognJ3ObmEeLp1O6LqnL
	X4a6qQsCEE0E4WqYHJmnBaD9cSIYFT6U7kpLzVnTt2R0fv1uOuZzR9NyFrPcihnUAQkOwphqWey
	k0Wyh7Y9/Kj/RYv6L9aITXlaGI+nFBRgm0kKi8y96
X-Gm-Gg: ASbGnctuu9E7WkrSA/cO/coy2BkqhfsdPcWEE3/YNqXJWjD6Mx5rjnLRTg12WWQo3ax
	xTVJH98sK3B5LSZ5AGVpRNH56EIsxhpyvhOjTfpwoTxnbL88Jrx6nOsaUQn7JhnGfJYN8atZF2H
	dY11M3XjOxyMrkI7zro5MC+9yWUd0rVFGzNhMTK3uhe7AkOPnJZo3H4GmCizfE8N/w1MtVfnHn9
	+/NqtHUxmb+We9+j5r0WjB8tYKZH7fGOZTR+PPNTOvEnx3MhK2xT0TTtZ6sGV0ek861+TfoEx+Q
	7SM/Utp3yCl+tH+ouzspOMpZ5g==
X-Google-Smtp-Source: AGHT+IG7kemkMTF75DLYgBeYC72cxlpVChE2EPbjfTmlF9qvTWS9jzyzy2BE7qmqEqQP1ek6xqr2wkfhFZev/XU0VsM=
X-Received: by 2002:a05:6102:6313:20b0:5d7:de24:4b0d with SMTP id
 ada2fe7eead31-5d7de244f75mr4084318137.3.1761091667997; Tue, 21 Oct 2025
 17:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017223053.2415243-1-jthies@google.com> <2025101839-startup-backwash-3830@gregkh>
In-Reply-To: <2025101839-startup-backwash-3830@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Tue, 21 Oct 2025 17:07:36 -0700
X-Gm-Features: AS18NWDlmX_v61JBT-NlUI9y7JTh8Ff3kMhR4mc9pCwQjIwup5yY3_5Idr-cCDU
Message-ID: <CAMFSARf1Mp5ewJsig5Pv_0n-kEsLq73Nio0i4r8A9YxTCHrJ8A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: psy: Set max current to zero when disconnected
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, akuchynski@chromium.org, abhishekpandit@chromium.org, 
	sebastian.reichel@collabora.com, kenny@panix.com, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for the incorrect commit message formatting. I'll resolve this
in a v3 update.

> What prevents this from changing right after checking it?

There is nothing that prevents the connection status from changing
just after this is checked, but that is true of most of the values we
are using to set power supply properties. If there is a connection
change, ucsi_port_psy_changed() will be called from
ucsi_handle_connector_change() in ucsi.c. This then calls
power_supply_changed() which should signal to userspace or other
drivers that this value needs to be reevaluated based on the updated
connector status.

-Jameson

