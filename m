Return-Path: <linux-pm+bounces-6201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FB89F40F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B51F2CBA3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD8B160885;
	Wed, 10 Apr 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3cKGUbR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6115E5C3
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755210; cv=none; b=u1ErikznIzkGCfmX8M9faZjEiwd69N57GF1LfLyobJ8fATYDbW9JCjNsoIWvZUak+iAlakjJAhtOUtprUMxJiKzi6AMPxzZ5qmdmAUDtqPce21KdF97WgTjjw8qVvzD7K7ZqrOerCNkiXAX7evTLx033SdMq7m+ReMeQ7lsKVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755210; c=relaxed/simple;
	bh=DMV8rRAuwne+3JJRMUyHz1rt1P+rRmjVj2ubdQfJ5aQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=P9/WsLUMLIdf+mQzmjnS1pYSps1jSYLjwJvg3pBUc3J6OKoxDTqgzfVi3Jo1Momjw6K5W3YujKfUAdB3cmqAlkZXJgFUNF6EfvrYwfZjWf2/xka1zPFSbZBL24NU6UcKQQggCtCm3ZeCvJO4o2OWyTOvdIwYdFPg5u3dJA0N3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3cKGUbR; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61804067da0so33382057b3.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755207; x=1713360007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6/yMlHy8DdiHw6a9pgyrybLxfmsjJIAXFnSukQCTX7g=;
        b=K3cKGUbRL2zMWACT9HupWppb0a/35WJcMk99tihWqlFp0Px9o23Fe+OnL8g1EMTwNl
         8soQ+P2+deriiFhGtyw44/SbpzPCPDXif9201OCfIxJqs++ii492hHmS69+wLft1vQoM
         Qr7WLhJzGX80DQxVc8XSbYl5vVozoyRZ49XdfVo7JgIx1fQKMYk0kKIUOaWhQBbO/AYE
         wOU62AZ61L8kRUOOo/TlgojmKloNR1oUKnh3jhYquxwvECyHrfFqGIWqKqn+ofoQ0y/p
         DspcgD4AKES5MuinGCKFI2ypoeXSGzd2buL7ZONADOK2r76IWEwfvK1A+NRgDzFmCIPO
         dAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755207; x=1713360007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/yMlHy8DdiHw6a9pgyrybLxfmsjJIAXFnSukQCTX7g=;
        b=fVjjxxX3oP0x8UJ05pLm/XUgNzNiz9ArbkHy133rtFkgLY8wjaf5C0/gP9I/6n5zOw
         vUiijW8rqRVgXedIEEBiIE8d0SwSOjxG3eHBtZoM3uQOt3NxGBTq4403cTf/bg9LpaEc
         2a3+6ZbfxkLRztHMjF3s3U5ewODFVBeWpBA0WEA9i+Z1hQ/bzyGAOpD5MlNNfJ2NtPYU
         jmqf7pc79V67YUX9A5uuv7j6+U1SqoLz5lTjQrLgr4uhV14dhaOk1Uco3YYHELuTlwTI
         9Sp5oTg+EWgL4AYOWsUPPioa27/ztWVQq6NhplQCRjuhQoi2h2rS4GZPgj3hkuEgH0qu
         lo4w==
X-Gm-Message-State: AOJu0YxeGxsw/lGNsTgUqPwRA2eHaJFsUS6vx93YZSL9vn3RyZaUqpFK
	FPgn0noqaUL5k2mptDggxGXk72Al9uhgoEsQc+LAvCpzUOz3WkuBGUiboGUE
X-Google-Smtp-Source: AGHT+IG3WHPMxfRYj1JxqqRJxR2CKpelZBpbTrk4su8jx3LqymCbfOXRVLI2LyvOJKylWH3gbdcMzw==
X-Received: by 2002:a0d:c344:0:b0:615:1e99:bd6e with SMTP id f65-20020a0dc344000000b006151e99bd6emr2539250ywd.35.1712755207193;
        Wed, 10 Apr 2024 06:20:07 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-b580-a474-89e0-3bb1.inf6.spectrum.com. [2603:9000:9f01:67cf:b580:a474:89e0:3bb1])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dd545000000b006143d243915sm2700864ywd.10.2024.04.10.06.20.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:20:06 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 00/26] tools/power turbostat 2024.04.10
Date: Wed, 10 Apr 2024 09:19:44 -0400
Message-Id: <20240410131949.442717-1-lenb@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Much of turbostat can now run with perf, rather than using the MSR driver
    
    Some of turbostat can now run as a regular non-root user.
    
    Add some new output columns for some new GFX hardware.

(patches 01-21 mostly unchanged since 2024.01.08 e-mail)

As always, please let me know if you have any troubles with turbostat.

thanks!
-Len



