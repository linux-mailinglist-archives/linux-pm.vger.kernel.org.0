Return-Path: <linux-pm+bounces-35283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4624AB9A2DF
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82A332435D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC63054D8;
	Wed, 24 Sep 2025 14:12:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233D1A841C
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723120; cv=none; b=OL9akuasJyJuEesFBNtlDESFlPxmnZp0y42+zdFLROE+ZuSXFfS7qdZeQFddsP+4uXYZoLvZUAfJWJMTVQTSAl1Wcg5Rr7iDmzVjM3Nqsb45ZpHKzLo5Xg0n+2zZHyfFZsZnQsHWgrOU0iJJxb53/BNGjWEnUlu2gLMn/mo2gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723120; c=relaxed/simple;
	bh=RAQppiXjWIWyTOC11PHSe910HHT72uEJpzqGu/pPfgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfrYr72tLR5ShQRTjCfs+5esVVaZR4nZRcQktFVktdTb91W8ZxKxkjjrdwSsDf4WO9DplQGuNH4ZvFo/6n/XAESG+lyvY1sdz1T2AKkAJ4zGYesPgxqCv8mUJNNdf4j6V2sYpfw/VmRTMeudjjQ+ELcNQq830lWEyOHh9Izvvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-859b2ec0556so28613985a.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 07:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758723117; x=1759327917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43BZO3RAppnebCnCAQY4LIb5j3YiQqsMBJqVptEFktE=;
        b=XtF/higOTcey45tDzMSP/0DM6SwPcqOE6Wd8ihFdHfTtVmBW1aMwlq1iNLD+1W2PFU
         4zodTT236dCihGb9hQQnOhwWjAgt5U0i2YowXSjetflTu79+HlnL0qpwn/900lNsWwXF
         9x4aAOaG07S7f2O3kHL56W4vpI0J2Ko9/Di5tVZTxHamSxYsrhvrOySG27mLRk/aBzVu
         tJMPsLAQMPzrkQfX/x7Qbl3Xu3pRhGu2+2nxqkrDBn1EYE6Byuzlnne+2xqyl3TwJOHJ
         RxCrLD5AlSwNsRDAB1zmN3ZS1n2EXIUO74p+dwZexJv8H/9WHLScWMYZIb5U7vK1C67X
         NY1g==
X-Forwarded-Encrypted: i=1; AJvYcCXINJptkpWTb4z5PqNRtTfSND2hADUizjuO+eoYeHh0vr8FifLTuzO5+j9rgotafcEqgSotcK7S1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3As+iicfC0ojnOKCeiRXBpMDYr+IgY5kMFUuOR6cUVXqD0gE
	CDpFS1W8cILciosdEeGTQm3cZj3ZdpdD7EksGntWrQn+geKK8AjS9Osptvjy6EN/
X-Gm-Gg: ASbGncvttCrgSrJ5LZCisqqxDUhA02t8OjksHsTdMXMBRdTymS4H4vxyn0eQvA0wIsK
	QPq/HmLPoNsnDduxZ3yt9Vf7BlveXo22wHMuoTY4qWczfwz9jYC11bs0RlgsRNN7qAHyIVBNTHj
	fyCH98kvtT3FbjFUNhdkmkUWEEhmbfP2Y0unZoM/Z0grKl/le52zQkGJhFYb4X7dAlHzjmN/9iX
	USlcbXOiQyeTaQyoAi1EjJ0cJsUoj5vC3z+uKZB73AeTDci+FjG6B0YMAhrM+GxuorMv7paLphM
	pKaTYHYFqe9+x64iQIhXqbLibZ8xV1Gwn2HMgeItSJQ/T8AJx4B/cDF9UgYdj3gNst/oHb2UwYC
	Hz4qojrdRQ0z+wirEfAk+ylsb/1NJBtYR/oVxhk+m5De96S3MgWebTc0Kyl084Yp+
X-Google-Smtp-Source: AGHT+IFSJx3gUSMazntEgqnZQlYBe4BS232voT/tr0Dtfdyb+HMTFypAvnQxURQnz1LI/mZj7RRavQ==
X-Received: by 2002:a05:620a:2588:b0:84b:871a:1651 with SMTP id af79cd13be357-8516eb46222mr738484185a.18.1758723117355;
        Wed, 24 Sep 2025 07:11:57 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8593bcdda34sm47833785a.27.2025.09.24.07.11.56
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 07:11:57 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-859b2ec0556so28607685a.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 07:11:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQpgVA9N00lPIahv0aVFwHO2RF0+4SOdH1+KQ3L6cyYFVxsp7aENEySoNnNwyZuXMcb42Yp4bzOA==@vger.kernel.org
X-Received: by 2002:a05:690e:d4b:b0:635:4ed0:5717 with SMTP id
 956f58d0204a3-63604666409mr5129283d50.49.1758722693635; Wed, 24 Sep 2025
 07:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com> <20250909113840.122785-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250909113840.122785-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 16:04:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
X-Gm-Features: AS18NWC4NdZL83Kq7qZvbj_wBXjrH_GSLKGUTwSbCh3zlppgYZIteZzcvWX4tWU
Message-ID: <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: catalin.marinas@arm.com, conor+dt@kernel.org, daniel.lezcano@linaro.org, 
	krzk+dt@kernel.org, lukasz.luba@arm.com, magnus.damm@gmail.com, 
	mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org, 
	rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 13:39, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

