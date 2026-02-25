Return-Path: <linux-pm+bounces-43179-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF/VIi4+nmkrUQQAu9opvQ
	(envelope-from <linux-pm+bounces-43179-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 01:11:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F9818E537
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 01:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A67E3019528
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 00:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7315ECCC;
	Wed, 25 Feb 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIoNnpjP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95293FCC
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978207; cv=none; b=AvErMFc6qg4FhBSZUiabgRdbg33hbzlKdvEF7KIhdOLw3oo+jNiN0Nr0cLLAc6M2RZX6Rnhn46FSz/zELrKytIfBecbM4pdPhZMS0DiogwO9Yt26xl/aFTdetqEAx2MOD+7pMj1z3Vr2SRTVUTa2dc5erDV1jz/CQKywl7Cdu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978207; c=relaxed/simple;
	bh=lnJzJYcUp8Sfs9nziKWZ5/7nLDmSiLwtdUfyUswMIhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JATadtBtBzcCEmRMudO6Fd5qSkxcjtfnJW8iPnsvM6NJ5jSmiUbCrrs+7y5G5msTWLYwjyO6W6zeXGMIPrVD4E4fGsw2zexXRZgTR6nJJg6OZgxcmiDFuXudqEQTQ24Aa0FxplY9YHt3faFsei7c71O3ipBAB0u6ua7nkwQjKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIoNnpjP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43770c94dfaso5935827f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 16:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771978205; x=1772583005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTN9nDYyDw1VitSAoVU8XmQ2K7N+PmzLt6G2wl3/Yas=;
        b=GIoNnpjPnPFWsnbzF7ILSfRnDIToBUEKfqnkOYP2USSwwKEH65GHWOSMpXtnThXYVr
         Mgc5uxcOM7Wx4CMEUsEb5hklGQ9CJhl0GYnk/reHHJwRrOFoj5uqWqvQaR+zTV6UTc+W
         7gooy6rUM/QF2sHSsw9SZZraJUYmkka8VpeQ6MI1S28LMsZg6YPW4y3WvrMRjftznpRg
         6FjW92tDpUGaqrq3kT1M3iO2ERtw2LXw6OedHa+SxHF0KxaS7JVWzv4vrmn5ypn6OwUL
         NFTuWVr2sBOx9GKDRc7/4zHkZzZ2PskwCfcyYtyjkomSusWxPC6eyClqorxXrs4tYX78
         4Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978205; x=1772583005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTN9nDYyDw1VitSAoVU8XmQ2K7N+PmzLt6G2wl3/Yas=;
        b=TLil9ky9lPoHrPdkvQKDv7+lGzShOb9QddugayOCD8yz2I8uLg+Xi0x+BYDh6h1xoe
         aFQdCamrm09TqT2GYAToXYHv6IJIb7cIqaWSYf4wFuk5YMi2m/9KWAedjrBSsKt51vRv
         0p8Jfwd+KueQ4Mtlmhh2crO2uoDHPyekVRXADoSHBpkBcaFipVzFgM5ac6NrL0JFGW86
         Xir4D1u1/l0MIeUZ4nsMgQRuQS+myEzQ/jon4vQZQCyyh00muEZxwWzU59FOPUbmmCkB
         SOY2dtEZjRX18gbeSOL3084R8SBUDkgYGB+WsczjxC2khtQYDzPoyZ6OdHLCUvoMMuOE
         ZufQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD82+OC/VAXzD0/yF502g6gEwhBTCcRLz0hLibYZn/tTOBiE7WPyCQoeCnZQrlm/l8fHTgjnX/Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaqqqNnU2JZW0LujyobCFpQe2yJ5NO4ZZ9nGRd2bDAOJAjZ0go
	p+z373vSufsJlWg22LQ21sZ6djsziIZbb7VLOydgZCyKMNPAzOVsRnHN
X-Gm-Gg: ATEYQzwMwB1oHpK7ozTmCd4hRVxq7rvse7ueokVa+2WvQagrXeUepW8jF5DMHspyoDV
	tX56D5EQbhVw2vccFv3rN7EHK+Flt61BM6ERE3eFPVXEYMcDwjmAGbtM/KfB9kD23b/yyyBWkE4
	JiW/cZP+ZNbps4IeldnosI5pyEZ1G3y1v49G0M/PZB4N5T+G3bpgaYjbQRlyw9ljZfMqFKncW3x
	dmF0YS/Ooxs8KjT8jfO9F+vmx/+9jsZsvtOAT6jG4El9E3IlsmIqXY7z2vGO6u3GEcPCgC4vrd2
	RaRwAmpS0q/Tl7PSbXXmj+W2dbollnHeItYzypWtWTOAqdqJxsmHOOaRCc5Sk94RkQ+nXM+9hKP
	8/3lImTO1eVUd8aRUZNDpe7PhltSEbcuFkOBAN60aiSYt52AHLrSMjZ0pmDf1yZDv9EbO67pb7e
	p8OgsvPaJWScpxuKqlK+s=
X-Received: by 2002:a05:600c:37cc:b0:483:54cc:cd89 with SMTP id 5b1f17b1804b1-483a95bec82mr255382725e9.9.1771978204745;
        Tue, 24 Feb 2026 16:10:04 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483bd72bd66sm28594105e9.11.2026.02.24.16.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 16:10:04 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: cgroups@vger.kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Date: Wed, 25 Feb 2026 03:09:17 +0300
Message-ID: <20260225000952.2778156-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43179-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03F9818E537
X-Rspamd-Action: no action

Nhat Pham <nphamcs@gmail.com>:
> only tackles that same problem, but also achieve the dyamicization of

I think there is a typo in "dyamicization"

-- 
Askar Safin

