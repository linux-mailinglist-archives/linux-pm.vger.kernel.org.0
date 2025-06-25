Return-Path: <linux-pm+bounces-29468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E853DAE7C4D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0110E188DA12
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948E2DA77C;
	Wed, 25 Jun 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="2f20f7lh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B952D9EF5
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842819; cv=none; b=rJ+G6DaZvf2LOoIE5R0s8ctfojMORtnMArlgyNKNfU5K6rM37DsD/88EfYJvDmSMNDgESaf1S9Iqh5O/7kRwRuSgvShs40a/N9+W/06g446wP2lPuK6q/3U8M/akQ9+ZaBaoY/VQ8gmQlUqklwiBXP9Zz26GaCvcbITJf2TiYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842819; c=relaxed/simple;
	bh=r0M6S+8sborTozQR+msrdhkLnPY94JjF8rfiMkhWlk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0IW+zFwnR0jjSbLVZRU8+CNPlIlV3BKdmDiFS75wLwGKtUzS3zoP9fxYNrJsFKypWDgaR0kc2p7XBJEt48V+7gF8I5CM+rgBR9/3rbD8VBbJtchdpmpJJnoHIkkwxfIpMTwUrClrVP9POXE/mtVYqVoWJZz4KHr3iMPIbTiu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=2f20f7lh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso9749844a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750842814; x=1751447614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17G3N7jRvQMr98ZDvseO6MuQGAn4fzRuTBF5coR9VHU=;
        b=2f20f7lhssQVmnbq+2YohGa3lU5ehMPDrVI3yhArGEllQDcnhB8kV2A6Pi8GHRq+oM
         kRw5Q04Ad0Y6behcVuuzVUcIPSNH6+TaTH75vqN5a1pV7N1utuhahFCi3x6RhZRil1Et
         4cHgdIdh1XFQoXoHkD7Q9GdeqVUjhxwT4yXP0di3KdS9NnISgqjOaDWuMG5dItEeinc1
         mcW5A8w5dUn/zigC/UESt0oox1BuXJs4r+hUoQn4wQG0ukkS8AWD1UV+VFoI6cEmm0M2
         1y9pCQySVONevuEkc/X/Djs0awVrrEyZFQS/o9REFGPSY+IBSZVXTsU3iv5jhFPtNTYT
         ifrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842814; x=1751447614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17G3N7jRvQMr98ZDvseO6MuQGAn4fzRuTBF5coR9VHU=;
        b=B86Q+8tCj2LNsVNae8rGrlRMkkWEVNzmNU9LaE5WKVhBBdN80I7vqIswveSH0/K/BR
         pAEC/ZP50rvYhl332i8UD96DV+WbKVuNeFp9HgpGrpg49DUCz9S7l3K4mOBneT8plxTk
         xXQUUeRGdOI1OSVtQE1/jnuBz3oedUqdb6Lfuf9rjbG2EvpKaiq4gUZZV2dYScfSKHqH
         9fyN29jO7DNd/CYt/tguXiWoP52OdAKxHTwF02JFFOdnx1YtdDDhHmum4Hm2Rxx0Gws5
         GgE1vF0uGs147c6IfZE61G0c8odk82Uyyy+YuwYiHpM51pxv3iYk+kSz0aCQDvi2cq/Q
         z9TA==
X-Forwarded-Encrypted: i=1; AJvYcCUfhtgKFYEU+uZN5Xlq3T9RgRz5uc2tX27z3rRJ//AZvRnpLNKSb7vpaiuXWujHnGDlLDW5Q8h19Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpMVzAwlq0h+GmpyJyUXT1kkax/wnhnAHad8EX8oMlNUHIdJc
	4M5JiHlfpSahy+vV6VRnYFbOog5houG4Nn9dSQF8ozJPIdkghpbP5jFcr9RqZ7PHXfk=
X-Gm-Gg: ASbGncsPTtNrAH9Y13u1JoxNdC3DO+muZ8U617gFrhaHsyT1kiPhnIoZH9t1YBYpeh2
	GQgqKPPocimLnyYupp3haMvilK9Xp6b1GJ5T59lGXjybG17H7E2ko9aCpaGcf0TtD4TIQFk2zjz
	J7xerNzPktt4Xmz5lsB+hllgQnd4ommMElhQwMyp3/fV7WFxfwK7vzhnMHQHltB7fdZQUEalm8L
	loowHE72xIgiSbADXdGguDUq0TS+kZZ33dpAlcvVfwIUO/0wHvlbc8UiDYcsXQquB5jwYj38q7H
	09mt54m5i7h8REvJgaD4nyvZYlyI5jmzXuGm/zNf3G6nqwstO9lpA/XqcS3IAlRSpu+yUB3eZNN
	JYYZsPB0f0bI4l2bq/d9JubEnXRuJLK3W
X-Google-Smtp-Source: AGHT+IHtN8rF9jT36FGFeY24lEgEDKLCBuJ72j4a8PMP55mZ2eMQzN36PcTHorCZJo8JzcTmKrJ8fQ==
X-Received: by 2002:a17:906:1343:b0:ade:8720:70a0 with SMTP id a640c23a62f3a-ae0bed1b20fmr173874866b.20.1750842814425;
        Wed, 25 Jun 2025 02:13:34 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b719fsm1002786366b.128.2025.06.25.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:13:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:13:23 +0200
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the SM7635
 RPMh Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-rpmhpd-v1-1-92d3cb32dd7e@fairphone.com>
References: <20250625-sm7635-rpmhpd-v1-0-92d3cb32dd7e@fairphone.com>
In-Reply-To: <20250625-sm7635-rpmhpd-v1-0-92d3cb32dd7e@fairphone.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750842812; l=844;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=r0M6S+8sborTozQR+msrdhkLnPY94JjF8rfiMkhWlk0=;
 b=JV85IXCu5LtlvDSqrWSOtV6SHyeq8t6FfsfSBOEDVLp/36Lns7YV3pcMTaXDgEdRKDDTH/syf
 ao5dIEG2k1ODU0PvHFJhUxGtE4GJnPg8SEVxPypJ6v8SaE2FwXCYhPN
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the RPMh Power Domains on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 1bf65f2a583ab70ac313309f917aaabb75dc3f85..5a698392c657330d7d188c33c0bda46be5aae690 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -56,6 +56,7 @@ properties:
           - qcom,sm6350-rpmhpd
           - qcom,sm6375-rpmpd
           - qcom,sm7150-rpmhpd
+          - qcom,sm7635-rpmhpd
           - qcom,sm8150-rpmhpd
           - qcom,sm8250-rpmhpd
           - qcom,sm8350-rpmhpd

-- 
2.50.0


