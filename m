Return-Path: <linux-pm+bounces-4552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDB986CAB0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 14:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D51C20A4E
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835012EBD1;
	Thu, 29 Feb 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGMjaLI2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E712BF22
	for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214693; cv=none; b=rI6vBkmQDrRILlwMk1noJebyV4HqoLb6TX8UzBrN3T6WLSRZ6b+uNSx4xAd4zJulQcwQG+4JBEHDp3y4vT1R5fye67FwgcqvksrsMKDcIA0GoCdieLQrYVA5l7HYLYdpi7YZHqFnQ/ZbRFRsxuBJknvHgiM/NW+eHkVaYtFVjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214693; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rAxQv/z7LZZoavLsgoXbXXOvj/J8+NV1Mgvx2bQRYTqf/AX+8kSoMQk57lov5hWhRHDX+P2E1Dc1ZN/sYo9HiJgCq1Z95jTFSthGy1POxqKs0COCctUzJ/T4ML/lSyqQZlw9zuH7G2OVwH66/dY2HxNLhfwe1rKK6NxJiv2dCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGMjaLI2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e552eff09so133390366b.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 05:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709214690; x=1709819490; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nGMjaLI2h1ibLjApaDEGGh5jKh7QRU9iRVKykFIaqtWKzmPjT3lr9Z7Kr04qI7et3s
         RTboDpNGDvqtpy+wpI4ATjIyF6yWE/Y/uNi7vLopPV1x93UDQ4/T4DR+HbpqqHvwmMfq
         ulMAEuh5nZOMA4ABa9FiafMJb5HegH+/r2euHXWAb1jbfCs1OhGV3d3IVBomqVgXUEXT
         HVHlswP2FMaGcKfuL3P8cW+eXYhayEMEaubuGjH63ffkxwhmYfJbWqyUvUp07lHoObZ+
         wMbcq7XUpWO0nIwo7pSEr9jpSoxAveT2NtHglWb0it230f+3Y3UlbreWUsWt2My/T/at
         o8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214690; x=1709819490;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Zr7MMtMSE3FRb6tydp70rIVbaIE8zjIky3G7HX7NGNVCCCUBDDfQMbP/uOihGBYVYx
         jSJfqmd1KOQl9CT5rMWqox1G4VBvQmrDo+g7F9kRTLpjKxi6JFQnEvLMKaPhF81d/rYC
         +yyLiBThId7wufU0L79smoL6CNtT7Bmr+3CKUAd4k1O1lBKj2ha4bZaJMxXQ5Lh/vwfi
         3bhNkhtf3SSgK+QoqYaG/HbqP+XYGzKU8KfahxNgaKOr5qq4G1SiEm+M8OyN9OarGkpo
         jm4rdaKp2ijC+vOHNHQUrd1Ftxw9C/VxflxcFeV01wZsurImxhzdxO/yuWSh0A8c5Irh
         fqZA==
X-Gm-Message-State: AOJu0YylauapNsgZK7x3ThGtK6YO9hvTdcXyjty4nWgeNtdHAuGOGClo
	8T4KNXKGJF8CzCSZxKMzz4wS0LpReLlAVE++peC7No3gvSJ30EN+45Dz8F4b2C3dim1+caUDlHg
	iBfhr0jT67wWvCUOUS2jvJ/1y4TLDmvB7M/CDPC0W
X-Google-Smtp-Source: AGHT+IG60BAVe+zcN1kFk/mBWnzAGul1oVTqqU1weAs4u03v2F0V6KJavraOzLY6RTJ6I3qsMAsdWzyDswHsPWa3hn8=
X-Received: by 2002:a17:906:57d0:b0:a3f:6b7f:11fe with SMTP id
 u16-20020a17090657d000b00a3f6b7f11femr1407937ejr.66.1709214689815; Thu, 29
 Feb 2024 05:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lee Adolph <soslordos@gmail.com>
Date: Thu, 29 Feb 2024 21:51:18 +0800
Message-ID: <CAM1MrdRTZezu5OynAFhS-5vb6pnQqXqVHk3mR96rU3OzpdRt3g@mail.gmail.com>
Subject: linux-pm unsubscribe
To: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"



