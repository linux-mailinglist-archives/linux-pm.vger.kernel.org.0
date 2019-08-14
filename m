Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543708C524
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 02:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfHNAfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 20:35:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41015 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHNAfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 20:35:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so5373437pfz.8
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 17:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=HSL5yZkTigtq3mHBSL2omFvZGh6CImDi2PzvazVrMSA=;
        b=J6AKQk9kFqoP46HdODtVDss/nseRY9JpwV1IdaYSlMxP+KC/WBz1CmyoF1PaVVeczI
         OXweYNBx9VKchVNzzzmErWWIKcXpvZdZM4awFR8bv9dmi+fymrreeh6UK9yb0Sid4hd+
         4opyabtLOKVe6fYfQNDpitVl+My445gNlxCEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=HSL5yZkTigtq3mHBSL2omFvZGh6CImDi2PzvazVrMSA=;
        b=Y5SP0w520VxYlZygKAh9WKp3/tShFpQKkRYOoM8i8tqnv8qoNWzNdz2zeJaTnzALoj
         Y924BhH5JDReJyeVP4nhNtg5Fp4V+en3zbbwm13MV/UTdh0GOXgrMmCnDObc4vBlmk9r
         Di6QNPWb92nNZ9NmPzQ/OB2QzJxqjodC3+Q6CK6GX6WDaMo7w7BXVEayO2WN8pMryk5O
         KINsIh9J72/YYdb8wcQQ7cnw7d1SG983AWgD4JQTf13cBBkkN26mPgHRbEl7V6+MiYvU
         0GwzqMD1U/3pmuXc72uTCM4BCEB0ZU5/exfXiR5YDdOTSkxjwbtjI+/5GBCR19Egylq+
         /WoQ==
X-Gm-Message-State: APjAAAW2O8aENqoj+Agj7yj4neVZNlCkcoQ/UbUghmNlws/7lON4XIW/
        VTLsJzgfXk7tW/jQotbOJtKsm2P4Vae7gA==
X-Google-Smtp-Source: APXvYqxAGnfVcezj+08pwGn27gLP7EWedroG7GpvZ839EhiYhNye0C/BovLgfSe3r7eHTWjRd6o4Qg==
X-Received: by 2002:a63:8f55:: with SMTP id r21mr36428314pgn.318.1565742911670;
        Tue, 13 Aug 2019 17:35:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cx22sm2329301pjb.25.2019.08.13.17.35.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 17:35:11 -0700 (PDT)
Message-ID: <5d53573f.1c69fb81.a2ac0.65f6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565731976.8572.16.camel@lca.pw>
References: <1565731976.8572.16.camel@lca.pw>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:35:10 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Qian Cai (2019-08-13 14:32:56)
> The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [=
1]
> introduced some baddies during boot on several x86 servers. Reverted the =
commit
> fixed the issue.
>=20
> [1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.co=
m/
>=20
> [=C2=A0=C2=A0=C2=A039.195053][=C2=A0=C2=A0=C2=A0=C2=A0T1] serio: i8042 KB=
D port at 0x60,0x64 irq 1
> [=C2=A0=C2=A0=C2=A039.197347][=C2=A0=C2=A0=C2=A0=C2=A0T1] kobject_add_int=
ernal failed for wakeup (error: -2 parent:

Also, this is weird. Why is the kobject name just 'wakeup' and not
something like wakeup0 or wakeup1? This is why we're seeing the lockdep
warning happen after, but I'm not sure why the name doesn't have a
number associated with it.

