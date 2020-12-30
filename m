Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2022E79FD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Dec 2020 15:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL3Oh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 09:37:27 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41178 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3Oh0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 09:37:26 -0500
Received: by mail-ot1-f47.google.com with SMTP id x13so15499707oto.8
        for <linux-pm@vger.kernel.org>; Wed, 30 Dec 2020 06:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEd+774bQtaClZ62Rcq+ivloyHhYF+ctGTMT2QYYj/k=;
        b=stBBAMde//0phLhyV9Xqxo990QbY9XFbgk95Nu0hPLDmpKtAfqTA6YbFkjqOvraNaQ
         C58UIkouw5yRHgZ186b8ucjdMExWUtJZAxz7tc3VCTTcHuL6sV1jD95lmirJTBIeR+02
         wL+XA6qFCmcyOP8h3JOfZaiIqQrNTuV85IqSdSHO2T50Gctdmv1UZkrK+kpTWbdNB5Ms
         3L+jf8DDXX3KuaFAqgczcxOnAD4R+2dIm+CdnCGXADZBE/qdRRCzNTgAeNTuxhRv3unC
         D4KfjvjExNgPhXogOAVEvclvTPcVVSnEhcY95cmnLIFdYNrFOB/q8cwNOj9eSJtTSQ+o
         QpsA==
X-Gm-Message-State: AOAM5339ViXSrxpO+1YeQ93H2CSvHAzHmVumdOhgE3WEHTraK+3FL4vE
        +l+Vr9rCRw5nyX8Vjq2ZRMRLPPWLgJ/BqY6FtzNVQRl+
X-Google-Smtp-Source: ABdhPJzo73uqkV4K8WGUHyHbsVRsfJs2VGHKULEayzSk7dUVsB0yT9Lpm8WkFvSMS5LaqMaKuNYrM+KS7j96dlgtNbY=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr38575735ota.260.1609339005683;
 Wed, 30 Dec 2020 06:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20201230063828.f6qba2h7nyedb2dt@vireshk-i7>
In-Reply-To: <20201230063828.f6qba2h7nyedb2dt@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Dec 2020 15:36:34 +0100
Message-ID: <CAJZ5v0gAciHkgaUWsE92k00d1qYn72BhSN7M0T8Wa6ttsaPXKg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.11-rc2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 30, 2020 at 7:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains two patches to fix freeing of resources in
> error paths.
>
> -------------------------8<-------------------------
>
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
>
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 0e1d9ca1766f5d95fb881f57b6c4a1ffa63d4648:
>
>   opp: Call the missing clk_put() on error (2020-12-28 10:56:22 +0530)
>
> ----------------------------------------------------------------
> Quanyang Wang (1):
>       opp: fix memory leak in _allocate_opp_table
>
> Viresh Kumar (1):
>       opp: Call the missing clk_put() on error
>
>  drivers/opp/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> --

Pulled, thanks!
