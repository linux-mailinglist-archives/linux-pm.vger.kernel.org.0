Return-Path: <linux-pm+bounces-36632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE61BFA87F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 956523421A5
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266712F60CD;
	Wed, 22 Oct 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ri65JzYp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CC2F5499
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117955; cv=none; b=C7WLmSJG0c2A/xhxqFoOR2YJAe7BIef1UQreoe+0dR9BTVRqdFvVJOlTy9R25iPmOzbvDadsRiDmEAPbiJoRJ/RbbqQmDBF67OtgTqenIvNN+S41uQWrkNwk9T4xNgYpjNTGVrdf1qI6BdxzQ77kphE9mcp46t0swjdbp75WJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117955; c=relaxed/simple;
	bh=5N+bM5amrNetXwXJxRuKz0Pnn27FUWJd6XEgHZXg6Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZBGRNYVUugti4JrZSpZqQ+NjFzN24WPCIGiEvCcV0QKhqbkOC+wfGUoeWQ4KJtyCK4Aug30UtOJ9FnPBlkHUCW5hACjgfP29tUK2ZvP1RnlvylTMdKdJOi8WGCT5RFhv+q2Acq+GThkGM4jNkowN7psXdXVamFut0PisbNDG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ri65JzYp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47106fc51faso76905285e9.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761117951; x=1761722751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKMoThOVBKwHugFJponVe6vbvCHZyCwokPD8AF+alpc=;
        b=Ri65JzYpaiGjNVRoLE66+Za0BWXPSvMvIz287hil8hacoVa4rALLTcEHkyCBVKfviF
         r5cAbsnZEy7KZCgHdhNYmr3X2OTqjvGtM/Mp6DgzmgwMAc3LvwWZAGK30o+wtRvWFSCu
         paycjfuUaKixEjEjFI8FnKSMY2D/OBDtswVWzfWBMvyGLPKilnUBtkSd3V6GwfrrgstE
         dCjNE1lzm2v8780XvBzvtYCRo+9crc83yQGNfVi9TCeAMYzMTuTc7QZQ2+ITZwPOK9yY
         NwROGqCUdMc/52N1zEEsk0wi7z4TtZZWaCqf3/xirLpTYIyweYDo7Ym4v0DeohNj3AAn
         SfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117951; x=1761722751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKMoThOVBKwHugFJponVe6vbvCHZyCwokPD8AF+alpc=;
        b=DSjUxJ4nJpRZzpT/F58FNHx5vk291jlvl0+TY3RWv7QpWoFkHu8ZgBPnKHnbTjUXqD
         GTKVwJ60SlSpV/oKfeuHPBzgZn1Txr54p1YiLTqs2OhQpnmXJy3pVMTOPvn9IshUsr2i
         YHyu3q4sujYae14HsL+gUTQM5SB2L5BYdWC7zYMcIdqc5Rekspj1I4YTrSxTcdCjjnNc
         e40ueohPJTRYrt9gRYFbncav7N6YuOUxQ0GCvUjNvoQfof3WP02tzIn1GhlaojFU9Kqx
         d9MSiI9b8maxGBHggstqniYILpbu1KMSVJzSUAIiqfz3MtzgiObDSgz0L5gXp/xmca8f
         78lg==
X-Forwarded-Encrypted: i=1; AJvYcCWO74VaNBDiveLg1xXcgdZhT2H5jYbCR2xXczJPs9G3/rRc354hpQCu+T1o0DkPMAtxRvg5bDO+sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynUlFcXbcq/6tPbkZ74S/QWfWeIWbJnrSyHA/h0xWv4/Tqg9Fm
	blqIU+HpIFPYyzbeI8PtP3pXHduO0G3J9hjsaCn6uQMSE6tcuXLMaKlbItC1MI++CZQ=
X-Gm-Gg: ASbGncvQlRQM+tpZlIiF92+UE2CkS2ycZX78D6xNJsocoVuyxAVXpTyBN0g+I5KVii0
	W91WlbtLMAarRYra0a3QMYK/FRAblfYaIV60CxsgwrKqkpa3L39HifJf1n0u9x/pt3YqkXhGFf8
	QX7+l/iIJT2g4hZ6Lcs1Ha28HhD7rQwLljdxaoxbObZQR+MbSUBkziDvIp0lHxemNlojbCHhjin
	jrIfzvAryglShI3BwXuEPtg+WhbG/4FqDzwLn+dKW3ckdC1VxwlhwMPSZaKrDNN32fa0GuPnSqu
	UlNkqOuOgOEVgDVlSIkTkBHUSber8sdJA3pm46XtCuewCFCGETv13K9RRegA9HBSYgNpv5FFQPs
	j1aGQzTZqTxQrU6loJ1MRYzzYbchIO6/nbs4ZxiBWHhKER99IhUCQ9b/ks4mvt5znpYPSEQTutq
	2MnD0o9Q==
X-Google-Smtp-Source: AGHT+IFlPf+i5rM3V2aPth3/QorfaAiBmBO6+U2yQMIYWYZnD3lbKAlJhKzYMQ1lM3lkudsWOGqQEg==
X-Received: by 2002:a05:600c:3b03:b0:471:15df:9fc7 with SMTP id 5b1f17b1804b1-47117906a72mr140545185e9.26.1761117951513;
        Wed, 22 Oct 2025 00:25:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c428a534sm33459415e9.6.2025.10.22.00.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:25:51 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:25:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ally Heev <allyheev@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hunter <david.hunter.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Message-ID: <aPiG_F5EBQUjZqsl@stanley.mountain>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>

I made a list of the warnings this generates (on Monday's linux-next).

None of the warnings are real bugs.  Every single one of these has the
assignment as the first statement after the declaration block.  We have
had bugs because of this before but Smatch and (I think) Clang detect
them so they don't last for long.

regards,
dan carpenter

arch/powerpc/platforms/82xx/km82xx.c:30:
crypto/asymmetric_keys/x509_cert_parser.c:63:
crypto/asymmetric_keys/x509_public_key.c:151:
drivers/firmware/arm_scmi/shmem.c:199:
drivers/net/ethernet/intel/ice/ice_flow.c:1576:
drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1015:
drivers/net/ethernet/microsoft/mana/gdma_main.c:1508:
drivers/net/wireless/intel/iwlwifi/fw/uefi.c:821:
drivers/net/wireless/intel/iwlwifi/mld/d3.c:1788:
drivers/opp/core.c:1413:
drivers/opp/core.c:1480:
drivers/opp/core.c:1797:
drivers/opp/core.c:1888:
drivers/opp/core.c:2874:
drivers/opp/core.c:2935:
drivers/opp/core.c:2989:
drivers/opp/core.c:3065:
drivers/opp/core.c:3085:
drivers/opp/core.c:3104:
drivers/opp/core.c:312:
drivers/opp/core.c:330:
drivers/opp/core.c:412:
drivers/opp/core.c:450:
drivers/opp/core.c:608:
drivers/opp/cpu.c:157:
drivers/opp/cpu.c:204:
drivers/opp/cpu.c:59:
drivers/opp/of.c:1272:
drivers/opp/of.c:1331:
drivers/opp/of.c:1428:
drivers/opp/of.c:1469:
drivers/opp/of.c:149:
drivers/opp/of.c:1505:
drivers/opp/of.c:174:
drivers/opp/of.c:276:
drivers/opp/of.c:352:
drivers/opp/of.c:409:
drivers/opp/of.c:48:
drivers/opp/of.c:98:
drivers/scsi/scsi_debug.c:2964:
drivers/tee/qcomtee/call.c:648:
fs/overlayfs/params.c:451:

