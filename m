Return-Path: <linux-pm+bounces-553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DD17FF31F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 16:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3008C1C20C72
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6E51C35;
	Thu, 30 Nov 2023 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="YAy2aSdT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF71A4
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 07:01:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d048c171d6so1419415ad.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 07:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1701356515; x=1701961315; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdYjao+HCUK8e3tBXT/1z2up+CFURcJ914zvXQUTK6g=;
        b=YAy2aSdTIWCaSr9/qS0a9TS2LCZ1CKrTBtN9H+HyB9zh8DloZPJIN0cEl2kQ5bj557
         czK0/DvoaCgWBbqIPq01q4SYcbbcYs7/oFx7hS1v7OUCE/9fF/BoVNQxWAXiicaW3STc
         fuzQFDGxET/vKahObpHXbwL5raTO62n97lem7rKOfJ2CdoolG5KF5vrabQ4NtBsYR8+1
         yejtuePMqbLzQK5KAojM8M+S2dODDvif2wzakayO6kgxkKR3ZWIMc7TfIz5LdBCt9fox
         WQJzmhbAbp3C0bWujkh4F25efhqUfEuy5qGreNu0iccd60D5Xo8Uevi389CdVsTgIqBE
         hjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356515; x=1701961315;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdYjao+HCUK8e3tBXT/1z2up+CFURcJ914zvXQUTK6g=;
        b=rv4ejrAlSa42xCX9Waae9EeIHOsyFBv86gR+3RmBPRR6HVYnCce4MAeLUhasQhue7F
         4zyCXfCK+vpKQ2N05v8Muo1ztZpvI5NE2uNnprTd3l83OVvM6TBHKqGuYLAKBPLI1A6f
         zZ6hBL3zdxYxfGR6NaIem7Q8BaFlnSRhDBfq6BzMhHNrzKDSR5t8IRESGUUokE0cgwxy
         lPW1LWnjAKKSatK3rvmDZAgIxXBOiCyANo+vUFg2NTbT2dt3OBRXZFp1W+WxysPfhiWM
         vx6Ri3wzSD4kjCt3qX/zWousBWv95SPhiGmYvEpQC4VRjpiCg1tqb18COUR9jGnmZMgb
         sC8g==
X-Gm-Message-State: AOJu0YxRtmwllVJE+fzC49by32enP5m1I08WHzmVRF7EneHx1a6HhEad
	GrOEeq+Hb19EgfAdfmjPKRvaMw==
X-Google-Smtp-Source: AGHT+IG1dPsf9WfotNgxa/zey4DT6cHSTFJGJDfFbdZmJ9Hb1aG9IVtQ+GKkE5yve9KzMLhD7CWLJA==
X-Received: by 2002:a17:902:db06:b0:1cf:c376:6d7f with SMTP id m6-20020a170902db0600b001cfc3766d7fmr21370400plx.42.1701356515050;
        Thu, 30 Nov 2023 07:01:55 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b001cfad45d6bbsm1469708ply.247.2023.11.30.07.01.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2023 07:01:54 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Len Brown'" <lenb@kernel.org>
Cc: <linux-pm@vger.kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <00d201d96670$e15ab9d0$a4102d70$@telus.net> <CAJvTdKmv-6rp=z=emS1VGdWgTmRfhSUrmUPLk8Hj+5=CvH0+nw@mail.gmail.com> <CAJvTdKmG2JkJBy4UNc101JZUHzUaC=a=U9Xwg9MgQs7wcDvYrA@mail.gmail.com> <001b01da22dc$e0f764b0$a2e62e10$@telus.net> <CAJvTdK=Bvkw+ro_quJ3y=+GAf1MHv5AiBu2kAY+V3Wn259maAg@mail.gmail.com> <CAJvTdK=rJfjgyRdg4-=xecEmcYnP86R4-K98KBgwa_6THitcPA@mail.gmail.com>
In-Reply-To: <CAJvTdK=rJfjgyRdg4-=xecEmcYnP86R4-K98KBgwa_6THitcPA@mail.gmail.com>
Subject: RE: [PATCH] tools/power/x86/turbostat: Fix added raw MSR output
Date: Thu, 30 Nov 2023 07:01:55 -0800
Message-ID: <000501da239e$2932f020$7b98d060$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJigUPX+JE/C/rArcKUKaY8eOCGfwDAEwE5AhpcgS8BWcYKUAKPD8rjAxA2Df6vM5y4QA==
Content-Language: en-ca

On 2023.11.29 17:24 Len wrote:

>> if (topo.num_packages == 1)
>
> turns out that is topo.num_packages == 0...
>
> Doug,
> Let me know if this tweak to your patch doesn't do the trick.
>
> thanks,
> -Len

Hi Len,

It works great, and is a much better solution, for all
the reasons you listed in your previous email.

Thanks.

... Doug



