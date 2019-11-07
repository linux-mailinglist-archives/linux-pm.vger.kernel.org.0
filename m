Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5090F2A4A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 10:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfKGJLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 04:11:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46686 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKGJLN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 04:11:13 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iSdoq-0001pf-Rb; Thu, 07 Nov 2019 10:11:09 +0100
Date:   Thu, 7 Nov 2019 10:11:08 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-pm@vger.kernel.org
Cc:     Clark Williams <williams@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] thermal/x86_pkg_temp: Make pkg_temp_lock a raw_spinlock_t
Message-ID: <20191107091108.6ctsai6bdomalmqj@linutronix.de>
References: <20191008110021.2j44ayunal7fkb7i@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008110021.2j44ayunal7fkb7i@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-10-08 13:00:21 [+0200], To linux-pm@vger.kernel.org wrote:
> From: Clark Williams <williams@redhat.com>
> 
> The spinlock pkg_temp_lock has the potential of being taken in atomic
> context because it can be acquired from the thermal IRQ vector.
> It's static and limited scope so go ahead and make it a raw spinlock.

a gentle ping.

Sebastian
