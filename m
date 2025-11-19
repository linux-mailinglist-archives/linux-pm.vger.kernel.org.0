Return-Path: <linux-pm+bounces-38234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA01CC715E2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 23:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 02EE03163B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 22:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B12ECEA3;
	Wed, 19 Nov 2025 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="K9Mf8wPi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58A329E52
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592217; cv=none; b=JJlpRv81u4j6rDK45Ox9utIGpSIsepGmftVBP95ZrTTKqSOHOXM47s9j1BXilIW6i1F3oyVNwNw9GAxFct8yljZa1b2vw1Stiv2/6nSi8fKxHrklC3hVdbSNob6IkhbNADk27NxHYplOg6FfGBTgW1PziH0tMr/+gwEN11g14bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592217; c=relaxed/simple;
	bh=exLQU2A1uAUo4pWL01QGupT/xazbPH5x+lO8FbmJmrc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1snUXcI54leMG8DeC9iwzDvzXc7DsMWxO8YT9LelQZMLcMC09Nlu52XQjSCn7spgk02bjrVmgSG+qMWTRVQDWpfJv37vnl07NFrKDGEJm3BscElm+74LZZSuxxzhM6aDtqpaD5A6hy7wZlEjvpW2op0DIs540xPWqGG8tQMEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=K9Mf8wPi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b75e366866so99742b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1763592214; x=1764197014; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjoVVBrGVNLceirqt6w86PFXimFupbw5muH/xGKrDMs=;
        b=K9Mf8wPiYSWTwOEAZjpHEPesTCDd08ueARkK6WFn/fc3XpCh2iYPgxE7CNwQYgZ+UD
         VFsOFlO7zBD0ax/gixOOW5f9Ifc17jZpVLJFYalIHgL4w/RA5XhORRhxyY47d33fclIZ
         9fkrdHuGiBF/DmSPUQexOqim0mud2kq/Mox5BYJRTS2OAh83l/4qSC1ZUaclHVJCY+ea
         hWhPxHNMQJhVEg7A1JEnEBVmRTuhkJfINlXnKN4M8ddF7E39NE1HpOIAmxqgzjlyVWLP
         F/rBRRQr2crb17dDCFAYt6fOLBZi3Jft8X30gxEbrdn4dmAi1s40OGDkSfpW/0DyytcI
         +yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763592214; x=1764197014;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjoVVBrGVNLceirqt6w86PFXimFupbw5muH/xGKrDMs=;
        b=XlHhuHlA4Q5qN2/vZnlvp2ExgAaB4L2lpDHZyC5zZ8gS+9ZKscqAxunZYmVfCvHhFu
         0wD8qUQyvIukHNZTMz3NwxzmrukE+jEMLKbdKa3UcEKlbpkcAabIKKMBijJchXn0MsTd
         TNM8fdyoFUvRbp3LOZwcu/uKm3Q0XXmrD8LE3gQtM770E5RRvXEBQLFXIaT5EykWwsc8
         kwIGzGYyiMOQ0/FU8OkaOn6WQwZDNmOcByX0+f6wZ2VXePq5ZhhsnRSxqG7RsEuhwg6U
         IKeS+adc4tNM9K9awFxygGq/qStn8N3OEaUulq37pRDCwDJlKNGCwGZz/Q7i2XFAEsUR
         2Fzg==
X-Forwarded-Encrypted: i=1; AJvYcCU3PpuWIqOUenXVVUsAHzvGHZ0u4/uAcXYe+GFUBmfzENE96HhH6/vpQu17ozUrQeeR8IDvRTJr2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/fpyAxmW1LvIUiqSV1+g/ikAHDvsfc+zFbmhbgiuivw8MiLN
	/PJsw6AdAuhM56DNdwQ8itKB5F/dSczs5+zPy8uPU2cF3Ai9xY0GtWs4twzlGQscIoM=
X-Gm-Gg: ASbGncvIeeyfxcpaLj8PCTBpaO0IVh57pIhQWwVZLIibYOhyxmcZu1QywH9eOKzqyUk
	scU9VgafmLaj90B/+VMncWLoucDLK308CfHeWl9dLayW5VEq5VzmuESzOIi3pozQ+Ff38s8XRgl
	18XaYxrMZflcezjRTlWyd1z4Or5zoL5cfAapsOoRMy336ezVB4vNsO0SHPvUYyRskFyAyjQsT+E
	gR0nVcqt7JO4fLcuiPk+zR4Lvb85fisdEN/7EJy6NY2lbgAOgod+opB5DwsZj6LCTG/4iALAvBS
	+lKPy0WKAlKc0fPzZ5SZ5sLUUQRSqphv+L4ZKeSH4gx7iEzSU7MywSpdkMf3F50XpLCRcx5wGel
	TJvaK0FtppdHR3skTHSvRXOBB5craxWlCUjid5QkWcZUKn0CoWIO6sbrqrQTnJMa8dauE5S+yFb
	MhMqv781HDN9duCZsG7emNt4uwEvthh+2xjLViXzIFwVVPYRH03RhkbPk=
X-Google-Smtp-Source: AGHT+IGswi+yalLFuZR/+1ZlAeORcKWhaXPi+3FTeM2Xwwo+cmOsmiUNf/aTqwcufRZrVWrVnziaZg==
X-Received: by 2002:a05:6a21:339b:b0:35f:fafa:a198 with SMTP id adf61e73a8af0-3613b4c002bmr1533019637.10.1763592214228;
        Wed, 19 Nov 2025 14:43:34 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f095c237sm424910b3a.45.2025.11.19.14.43.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:43:33 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>
Cc: "'Reka Norman'" <rekanorman@chromium.org>,
	<daniel.lezcano@linaro.org>,
	<linux-pm@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com> <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
 <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com> <CAEmPcwuVPMONrDHcnxbWpoG5K5DFwf-u2i7wuOK4Q9HvF2uOhw@mail.gmail.com>
 <2a429c41-8624-408c-9db0-4450ab76e52f@arm.com> <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
 <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
 <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com> <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
 <571fb9f4-56f5-4d75-a70e-d8741bd1fad2@arm.com> <CAJZ5v0ihcLwoMKcPe2RC16sjvf5acU0Y8vjccUu=fYgD+ux12A@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com> <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
In-Reply-To: <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
Subject: RE: Regression in TEO cpuidle governor between 6.6 and 6.12
Date: Wed, 19 Nov 2025 14:43:34 -0800
Message-ID: <003c01dc59a5$f0d97010$d28c5030$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHlet41AZsGUYXqd5J4NJ7wgh2vewLKMoeTAn3FA6oAlI5qgAJKDvBoAbkAIGIDGm7e/QIvh+5GARXxnD8A7bqRNgJF6oXoAgOXTuEC09pwjwEUCbAjAwsZXvQB+bQb1wHe+PDps+ZBsdA=

Hi Christian,

This email is about testing as opposed to about the subject and patches.
Specifically, the " adrestia" test.

On 2025.11.13 07:43 Christian wrote:
...
> Forgot to post the full results, anyway as expected with mtdblock (a very slow
> / low frequent wakeup scenario) the impact becomes clearly visible.
> Still hopeful that the more conservative approach will be acceptable!
...
> test       gov        i     score  %change    idles  idle_miss  miss_rt   belows   aboves
...
> adrestia   teo-m      0         8    0     103680         21      0.000         19          2   <<<<
> adrestia   teo-m      1        12   50     104026         31      0.000         16         15
> adrestia   teo-m      2        12   50     104063         32      0.000         24          8
> adrestia   teo-m      3        12   50     104768         44      0.000         22         22
> adrestia   teo-m      4        12   50     104388         18      0.000         16          2

> adrestia   teo-patch  0        12   50     103096         67      0.001         65          2
> adrestia   teo-patch  1        12   50     103128         57      0.001         49          8
> adrestia   teo-patch  2         8    0     102812         78      0.001         72          6    <<<<
> adrestia   teo-patch  3        12   50     102990         60      0.001         55          5
> adrestia   teo-patch  4        12   50     103168         24      0.000         24          0
...

I am curious about the significant variations between iterations for your
adrestia test. And what does "score" mean for this test?

I don't know if we are running the exact same test [1], but my "score" means
wakeup cost (periodic, 20us), and for the 6.18-rc4 kernel is around 2.7 uSec,
independent of the various patches or teo verses menu governors.
My results are very repeatable.
With kernel 6.13 I was getting 3.3 uSec, but I suspect the differences
have more to do with other kernel changes than any idle governor changes.

My typical testing command line is:

./adrestia -a 20 -l 2000000 -t 500 wakeup-periodic

Where:
-a      arrival time (microseconds) << Only used for periodic test, sleep time. Actually arrival rate.
-l      number of loops
-L      list tests  << wakeup-periodic and wakeup-single
-s      service time (microseconds) << This has not been implemented.
-t      thread count

Those run parameters give a reasonable amount of idle time using
both idle states 0 and 1.

[1] It is likely we are not running the exact same test, since I converted the
source code I use from uSec to nSec. Notes to myself from a couple of
years ago suggest that I am using the version from [2] and that the version
from [3] does not compile (at least for me).

[2] https://github.com/notcarbide/adrestia
[3] https://github.com/mfleming/adrestia

... Doug



