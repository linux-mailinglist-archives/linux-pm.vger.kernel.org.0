Return-Path: <linux-pm+bounces-39593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B50CBEADB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7313069CA5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14A3346A8;
	Mon, 15 Dec 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="H6FJAc8X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C403346A4
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812332; cv=none; b=e025TQS9KaesmKCRjadX6CuJD6oKQJcxN+/JZg5xzdW/oYDlwlI+y1QzX7oQGOc5Aw3Wye/235in6gql6OiD6sfC0OE/DWBd/Ycmtvuv35D7frObAbEBN8CRnjUnjybRsj3SXAypRMsaeYl51v/x+xC/FQvoCao2pUkO7J82q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812332; c=relaxed/simple;
	bh=p6TXBvjDh6qgcaWnx0SV8owIsLEZuQUARmz03l/TRN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4QimFqbkXVG4tjiWJzSrMPL7904vzYrLeFf7u+8dxiiFljDpvFBloWws0G3BpwyH9pXA6GjehJ9oxencZE+qNiHgCipGBgXBlTS/JejIgTLbReY9N9/4dnltNF7ccMLbHHkHszej4A2neSih17ouFu51H1AucrDrYzZxYaOaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=H6FJAc8X; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3f551ad50d1so1256335fac.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1765812330; x=1766417130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p6TXBvjDh6qgcaWnx0SV8owIsLEZuQUARmz03l/TRN4=;
        b=H6FJAc8XM34CfT5y9WJgYJy8xQdV/Evi5kiJLZWMYgz9J3zDpA12uF2ti2IaB1RjE4
         rrHZ7k3DX8XGJHR3LCvu4WaIMFUEN8Vp3PAXt7XkgKgDOv97raB9pvT5dNfbBUZ9dYMO
         GmwrzAxou9AnPK/s3QrFatz4BA2Pxjm/KiTu/6a21RePaSLd43DUz+gySUCd4UWwE3QT
         LIe/MrfBjdsdIHw1rjwEnbUT+XVCtH7csj29QPXmPDq+bZEfUL+FgHjeuI9OH/AfyjmU
         7mLs2IA6rwzkk3DrvvG2UcmaN0fSRPHXHDFLF+OhiQ5X44BO5m6odGX1Ny1Sjbhc7680
         5eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765812330; x=1766417130;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6TXBvjDh6qgcaWnx0SV8owIsLEZuQUARmz03l/TRN4=;
        b=VxCCkuCpoA7sZ4jjAdc8O54N8bAYyMuJmiM9LpxO2escTTxb3NCv+6c50J1M8uQta6
         J9i0LvyIm8JeyGW2p17ge1anyTnjmAJt+xCxCEJ+c9L9RGZTeE1E+B2MM2tUHNUgsHNG
         l1N7oK36vyvZDPNa8xi/S0duZAmLxS76GOM8DUAp9wgxz2vaOwUW4hXyFheSt8vMdjT5
         Tb5RGMGK0slgA2q8ylcvHqAEEv7jsXitzSI9eGvkP27/+o/MlaQWCvgCbU8kAqh+1fYq
         iZYaxCGqsC/Yqrh1V7IN2xawLFaa5UP/bHjkiXEpLxkQMp27qkT2Bg5qjjJ0dfS6n2u3
         cZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCUgkEZs1a+eqlUeE7dV6cxRHWskY9Ls09+SdPixLs78jZ1pwSOcn7QMCsVFRxdlzN198T5Ok3ECZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaJbOrG0Zbz583VIyGWHP31uC4DTbWcAAqr0Nf9E0/YO8eDyf
	C/ldnzs6MpYhuKG84AjAuUXXTMPkH12bsUfQCJo76MOOSJULbqyu2k6DsOLpLKOkzfs=
X-Gm-Gg: AY/fxX63emKiATmSs/DuR44X2BCGxyTg9Nzn/+FAXgdHCK1jDPXntnfq+zTfrt3OUrD
	bRUHUeSXXNsjkJv4o8CsnUfpAVKRNaT8R3AOuIImMYbXgqKbVXmNXS9hLNIk3FzkYpubdqs07c6
	wFPN2GSln8ztW7L9IM8jCk/sASxm8sZLehaZSoxXmSWXboBi9sCy/MqSQ/qPa21w7s+5YqAJvWr
	eGnIgrsknbebhOkAcYKNg7BLMkLii8mHi5WCTqLQN2YUaBwwAGEtKyb1nuWW0FBsGCtlgIhQz0j
	3Wz/zefYrJwr5X/PXhFLDSSk4u2uoB9MwS5gMt65ojkWFsyl9Ju1SF9M502CETiFP/XL7ZPrcY4
	Hl+zEVsCnuIrLvLxeKJPNbPxCp4M1JLPIHoo9gnzKe5Y0/xwFkDhIw69aECKAhSo5RYK0Rl3GqI
	nw3/G0XNC5vvyusbU+lg==
X-Google-Smtp-Source: AGHT+IHgPOrTRQF96zNhkM8x9pVuVnBQeIOdwAMQvt+xZMsAf4Jl3TGl+PrLSZ4K+eyqWUAooZJ3oQ==
X-Received: by 2002:a4a:e905:0:b0:65b:31e2:2e0f with SMTP id 006d021491bc7-65b45284858mr5277127eaf.66.1765812329818;
        Mon, 15 Dec 2025 07:25:29 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf8f:aac:6528:d0df:8e4f:ea9c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614b7c66fsm4718564fac.3.2025.12.15.07.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 07:25:29 -0800 (PST)
Date: Mon, 15 Dec 2025 09:25:25 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, mmikowski@kfocus.org,
 rjw@rjwysocki.net
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251215092525.6ea95739@kf-m2g5>
In-Reply-To: <33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
References: <20251214184507.21f95134@kf-m2g5>
	<33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 06:16:10 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> This data is not consistent with the reported frequencies M-TEST
> frequencies.
> I need to get hold of such internal system with the same processor and
> check what is reported.

Thank you Srinivas! Please let me know if you need anything else
from here.

--
Aaron

