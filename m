Return-Path: <linux-pm+bounces-21957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC2A32500
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540141886EDC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8576207DE3;
	Wed, 12 Feb 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKRD1cYW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32202209F46;
	Wed, 12 Feb 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359945; cv=none; b=oYQaw3DFVGjOp0PQ3psNS+PDTBztSxjbMgOyjK+OSpJzFV7UV8zRw/nRZkvesyVVt1cD95NCVpAooK4TFa0VnYh73b94N9D97KeE1BF70qPb2yjJWImqHHRl9GcUE9j363C1/GW8ZCVBZ8KA0c4SGliA+K+YFKb6exO108Mym5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359945; c=relaxed/simple;
	bh=s7hHeLHxalaGcIL8rwFO9IhAesCKLsnoNKCUDby/PEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h2AmSzOH8iCxLK6g9ZU4vx9TguDm79DZgwZJlLKsXT02ZsU1S3iiYF2jsjU8DadsRlRyYchE8FpEV3uTP9LbRvBZdD+Cx5Tfbeyi6Vi/rT5Bjf0D4ugnqr4xkzuWVWe7F1RxocxQgF/wZI/s95qRy3+MYpPey+U7pCb8SnU9KlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKRD1cYW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7b80326cdso615358166b.3;
        Wed, 12 Feb 2025 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739359938; x=1739964738; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7hHeLHxalaGcIL8rwFO9IhAesCKLsnoNKCUDby/PEc=;
        b=RKRD1cYW+YP7uV0z1t4mNQjcDt5fQt3vsyGsdmdBhoJFnFF43DdvSzARsJBQEa6cIj
         Dy2nb+e/q4I4KD35o/QYpp4Zxrvb8LAIR96+w7yqD3wgHKEpCKG/zWEWy9w/Vffkqp3v
         5pcqVhwqFKfP36l24YGA/h9D9uQhxm9KUZ/3tTiOGOnmRtUdU45QVhZWZBSb5rBGjFlN
         89B9UdY25MRIiw0kIR3Sob89BZZmnZfqygCcE51sVgXwVNjEwetV/kPUmaWrXyePq9gP
         hJhS/lfCGCAqK/Vc6YsUyzKpE5qZ7gCr8KRFvuvcKUBZI/lbFwxSkv2mgKjKMmOZdBhQ
         dl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359938; x=1739964738;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7hHeLHxalaGcIL8rwFO9IhAesCKLsnoNKCUDby/PEc=;
        b=cZUvSU+cAWyhPO/jGN4oC76mn4Uk9IbzAgqrH0Q038ySLvYKdFmrffOck8UIfffqRu
         OTpknmU0h6MrX5rVybsne6HVWiN25SK3FSMXy5k79d5LqLBZ4meOT13nVitJ8cFrLyic
         WwR9EtTqkvKip4dVVDj5/cIHV+nskUKnuuycsf0XG4Iwye702DfIgOcZJ/vBcEJrisf6
         7RHlkT/rgReTuRSxgcVFvfutCdsqUhlksmC6kQUoL0z7AAXGxhWEbalTN48M43obm+qe
         2fqyJ+jeCg1A+qduj3dM/LpTYYKPgEOqHVjrjPNa5mP31T5a2DnXb7YglMqCNF50GPFD
         EK6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTWhLyxqGdc0vg+N2bCBBDX7EEfwiKNcI0YFHWw7JutvY//9vhETSlwdgKZSav3eh3Be/tFSWMDyL0dZum@vger.kernel.org, AJvYcCWbA3uMpG8QinNgtw+b9ZSkLJhCj8xdxzbBeussmoz7OuUyfCoLz49LOZVtd0sr2IG45Y6LiPhNVLg=@vger.kernel.org, AJvYcCXC/yQApLiXPTfu2nHlJ/2AY9HysrTBAWBphufqHT78PGH1Vgy/QlZsDVqIKxof/iEghS/onwuWvzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nGi4kQQDa6Q7o8T82Vz+h2Mc+XUqQ47Ur3oCwW4K5WB3iurA
	fmqBr3qKlxMnK2nDJKEHuhDknInDTBTD8iegxMQAQNF+IxrWqB63
X-Gm-Gg: ASbGnctGMt40TCNdJBk2jtCH65L3JfedSpW4C6WpTT2X9Vl326XhLpq/XZQ4lKGsNvS
	yB+Y77ZtX1awA9RmmxToVHkVzYYKGARA5DzqvFC92OAWhs69nIyBF+O7MQEAs3Ah3RuzfP8JjyF
	3tWatsz8jRpcj9KXr9XGFohAUn9+DligsVmz4bnIZD9V0Xyu13ar7UT6y4AFeXpymfVf5Yzd2Bj
	sNjcsYAKKWIiahYMML97rIslChzmD6hn7ey+ZA+6Mx5jbs/StdWK7eeJI2laqTZDJL3kxbPzgEs
	jAU3RfMhaoFI2ALXsA4bGz9YBbrVFbaPVpAqGn87GOnmAg==
X-Google-Smtp-Source: AGHT+IGJJXndp5jBgYdH0F5LQVt/q3VMN6qyAAnLNn0OT4b42ec2KYia/IvE9C8PTwq0Y5hlfFGx6w==
X-Received: by 2002:a17:907:d8b:b0:aa6:a87e:f2e1 with SMTP id a640c23a62f3a-ab7f34da843mr200509566b.56.1739359938215;
        Wed, 12 Feb 2025 03:32:18 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bcd53bf5sm629950366b.87.2025.02.12.03.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:32:17 -0800 (PST)
Message-ID: <21e66060c13c6a3cc33592f71cb08975711a6adb.camel@gmail.com>
Subject: Re: [PATCH v3] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: kernel test robot <lkp@intel.com>, David Arcari <darcari@redhat.com>, 
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, Jacob
 Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2025 13:32:14 +0200
In-Reply-To: <202502121732.P7lZkbhm-lkp@intel.com>
References: <20250211132741.99944-1-darcari@redhat.com>
	 <202502121732.P7lZkbhm-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI1LTAyLTEyIGF0IDE4OjA5ICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToKPiDCoMKgIGRyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmM6IEluIGZ1bmN0aW9uICdpbnRlbF9p
ZGxlX2luaXQnOgo+ID4gPiBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jOjIyODk6Mjc6IGVycm9y
OiAnbm9fYWNwaScgdW5kZWNsYXJlZCAoZmlyc3QgdXNlCj4gPiA+IGluIHRoaXMgZnVuY3Rpb24p
OyBkaWQgeW91IG1lYW4gJ25vX2FjdGlvbic/Cj4gwqDCoMKgIDIyODkgfMKgwqDCoMKgwqDCoMKg
wqAgaWYgKG5vX25hdGl2ZSAmJiAhbm9fYWNwaSkgewo+IMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fgo+
IMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbm9fYWN0aW9uCj4gwqDCoCBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5j
OjIyODk6Mjc6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzCj4gcmVwb3J0ZWQg
b25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KCkRhdmlkLCB0aGlzIG11
c3QgYmUgdGhlICFDT05GSUdfQUNQSV9QUk9DRVNTT1JfQ1NUQVRFIGNhc2UuCgpUaGFua3MhCg==


