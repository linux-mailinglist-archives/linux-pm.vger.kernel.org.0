Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391F4686C6
	for <lists+linux-pm@lfdr.de>; Sat,  4 Dec 2021 18:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355670AbhLDRwm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Dec 2021 12:52:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:42319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhLDRwl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Dec 2021 12:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638640150;
        bh=ql03uAUfupzRDHG+goccS5+3Lf652L0fzUarZQBKao0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:In-Reply-To:References:Subject;
        b=FWUlk0TkJAOMBUBdbgSjNu2pCoL3OgMZhvUHTVtifYrLTQ/SUFSpCIxabWwby5sQV
         rGsDMvTRJmX/+IFimghNCop3lHnFCWwAb3FobOa+wp6yj5ZcdPmjQsO7N1RDRDFuHd
         O0looJWWRAB/U1WnrnXMwiO851ypmAwJZXAKz27g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from flodo-tb13 ([37.5.248.227]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTNF-1nGTtD3JPJ-00NOGn; Sat, 04
 Dec 2021 18:49:10 +0100
Date:   Sat, 4 Dec 2021 18:49:09 +0100
From:   Florian Dollinger <dollinger.florian@gmx.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm <linux-pm@vger.kernel.org>
Message-ID: <612CF780-056A-420A-A89C-F0D8888B8E20@getmailspring.com>
In-Reply-To: <69AD17DD-0490-425F-B74E-8E4D9C18915F@getmailspring.com>
References: <69AD17DD-0490-425F-B74E-8E4D9C18915F@getmailspring.com>
Subject: Re: Thinkbook 13s-IWL issues
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Provags-ID: V03:K1:UZBHIWq2sntlvqyaqpnfsWjM6QdQKTmwn3iMPsaxF8YPhK3HTq4
 h5zWDLD6DFLKrIooHC/qdfa6nmeeqlZlkL6QVew3kqZE8ioROll0sHr0WGaZiF/zh68Vey/
 6zMAdpnByjA4mrwKlmMMj7L51G7fXM9RL4072Rr+tHfFKSGR4qNDhydC45TQO8G7O35FwRI
 y7wa+nfEvnKare0fruBiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tjgls3BIeGE=:yrXFhIRMzxtRoaGBf/Ac5T
 RAY5YfEG6SB4QG6OUaWegfvoMCooowZ4GqMg/fLXJRup43GTdiHvIX0uMPbmrDXHczLMfie5E
 YX+va0mn3Kg1LqpMwmj24hnvzHoVEdZXp0fG9Ke5OzFeTrbqnpiVMVGqiEwB2bFQSW5Iv9dhU
 ds0rkkfy4nXLsDNWbH60hXrRZ7DXrTgKR2ZVbkNbYyd2RHhedHBxu0tFbpamNc75oL5VQLWlQ
 RzfI4Wj34WkSCNiYWlQEvROMuSEe2JZcLvjPvr7MOAR/GMEllOY5mTNjrb0bnDUuZiYZMYOpx
 5Zs/ZWLRwSMO4T0AIhMXsbH5uAKwA6tE6Q+WgFith137080F+kI+0AzlFvKGmmVXo6BaDN6aU
 7UvRE1pZpHW4nASEdv03hTdeusApgiJb0AkisgF2u07RL3sEHJotgsdGbWgywTU4lXNGMzKCf
 mNLtnQbnGmvAf3k2Wzcf3Ro1lVGFvAmSGJxpJQNNPKnMXECNgsBizws++NgRsRPi7Bl06HTg2
 G6otUb0TbyLMJXSey2LwyNZ935drIpnObfAaZbZ0eDLlz+fea704o8KLHHvpvF0/Mp2dKwKg+
 vV5KhPU8CI2CEIxV8RLq6iyppqdN5KRRelSu0BnDTEHCHddrapiT551cjSkWyW+pgOMGTvjJI
 /GnGLEyAe+zqsRj3+5EC1zHdsAwUbnRqE5FzFtMSYRQt/qyn3YrMLw163u3Fr4sHCgnllZ2hB
 RhyA8UeUK4kikSMW7C6ERDNYYFkHcXUz+MJGlbUVnPgOGWyrwv9cGvs3IeokSUZvDI+wcQrm0
 C2BfcZRgUzETkVjbkr94Y7A2aEnKQ67t4S9BqGm02DW06OBGR6BKrncoX66zNn0EmEkH/qsaz
 SfUhW0FHvud0em8+h3dI5/QpUHDrPVvKPFJG3qU0JUGcTPzkD93qrUv8BTIbcQpbKVVFnjgPq
 oMblpEIlkLec2aeDqXvnQBB26tZ1SRM2VoMekigcrkqRaRnlpMHt3pUtlr8A5NxCs08GJ0P8e
 jjBRWr2nEK9dACDYN7QDmJp6e93T8b1QZYWHx/visOr4Ni6enCwnNYLcSbMOVpHvvrd5kXvOd
 yedUoB2YTsgbow=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Well, maybe not always. But the most reliable way to force it to happen
is first putting the device into s2idle and deep afterwards.
