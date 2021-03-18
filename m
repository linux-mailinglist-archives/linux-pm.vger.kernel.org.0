Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD5340DDF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 20:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCRTKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 15:10:07 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhCRTJz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 15:09:55 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4rD7-1lNEsO0oHX-001xMS; Thu, 18 Mar 2021 20:09:47 +0100
Subject: Re: AHCI SATA Runtime PM
To:     Alexander Monakov <amonakov@ispras.ru>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
References: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <f84fd43d-d08c-05b7-c1e4-ee03c1eab9d0@metux.net>
Date:   Thu, 18 Mar 2021 20:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u1jRHVtJG+eWUepn3VcO2LJWpwZzbt4NT56Y2FHoQzItxq6vKg6
 xVYcRA4zNGdVMVgWiCjytSRfEVDDPXw+iRuofS4uJSgTXr+QH+2UK1F0+gvTOLiV4tWlgts
 uDuNXIAYXqZbF2+k5FgzfV2Uk93/fSTC9C8fcK8uloKlfEmvltFc+RoJnSK9AcZRptFJGfd
 80Lnkb+5CpqUa59OCuFYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vFIeivT6U4Q=:zNlqYRckpZPLkwJvlqTgQ6
 xJ3FU2fXaz4ot4+WHjdPHnk0K1l7dnLooTnaIKgTJTgPwVCEQ+Lg+B1ENDZWWyqs0zk8vr5lS
 OsvcV3PxyA04qSMa8vjkUGB/z1gOvd1v06zzzl4SAFzClP/OjFu0eJpoPM1aHO4jdFt4dW43D
 E3TX4pBivUduh044HahooiP4jwVjCEOP1ZRkFVl+KQXZQJPsGHTjlny9JT4xevYOocUHOVSFc
 XpikYJ16p1rms1mV5nq8axniQmFIE8sX26c2yNkKcmTl+CM+PkgrXf1vNwdGHaGM8Twf/JN0o
 seL+5JR/OdXNk80Q0Z6K5Q0DkzPi4wgqXjr+OoSRXNil7X+IcsM+hdEGex4UoSk/RU6vK98O2
 XBEdPZe0ElkhqeIfS9XFG1XuY4gyPvO/jNw90onqKl6KEt2U3Cy+sBNBDTIgs
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04.03.21 16:34, Alexander Monakov wrote:

> I have a laptop where two unused AHCI SATA controllers are present (but
> obviously nothing can be hotplugged into them). Apparently due to the above,
> they do not enter runtime autosuspend.

if nothing ever can connect to them, shouldn't they be power off
entirely ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
