Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFB2D7E0A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404841AbgLKSZU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 13:25:20 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44330 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405812AbgLKSZN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 13:25:13 -0500
Received: by mail-ot1-f54.google.com with SMTP id f16so9042979otl.11;
        Fri, 11 Dec 2020 10:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qh6wHmhhofZ9WWJtuehr41vo0jvFj1GisT99ChBHito=;
        b=n9TqpK1ZYHt4wPAY1tppqDFyqZF49CqiOfVJxgE7QmwDrGAW1QaGJUaaZQ0HzW5APR
         We4tkUlktALFmNk2khWWkdMRrkFlAUTccBB3MmFqNvOjq8ptqluhcp3Xdytx1o0QyInX
         qZ/eVK5mIHKLtWk6tSGGVkswNYCAjTOLX87qNKLMuXWBHUZYq0Gqv1hkSa9p38hxCc2X
         DGPw5eaTXw2chHX7DmrB7Nm+kAIcbrtPyhB8iNyYZac6PIno3EIlHrPe64ZMrLFdg7iw
         3uudp2Todvgs5CU9LxwOOsoL7D68nGO2FL0rnye+EMavXZHvDRiIK49UQQfl7swyhSKZ
         5x5g==
X-Gm-Message-State: AOAM533VHu3FU9OzO9Te4+9J3ODOXTsNIdKfJGQkFasmvB6dTyZnCjc1
        yq6jSHwA7o4PXCghqLd/v9zDG6MzTVlvOVrAAo8=
X-Google-Smtp-Source: ABdhPJyN1M4YKaFJIf/vj77DVqzynCXrjQ7IluRmISjymEcZury3Fbiuu1+WuzwcwzkldWUep1DU7AES0nLghJyOGvY=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr10901809otn.321.1607711072194;
 Fri, 11 Dec 2020 10:24:32 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201211074332epcas1p27c7057fae84f6b6535a7bc4e89737c20@epcas1p2.samsung.com>
 <56c09abc-da54-5e53-3313-3185fb84bb71@samsung.com>
In-Reply-To: <56c09abc-da54-5e53-3313-3185fb84bb71@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Dec 2020 19:24:21 +0100
Message-ID: <CAJZ5v0hS=Se5e6K5F=M-evyYcGYZQtuUvr4MoyCEPVRN5LRCDA@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.11
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 11, 2020 at 8:45 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.11-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.11
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
>
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.11
>
> for you to fetch changes up to 6a575e84f11e15078629f0d16bff2bc354a6bfc0:
>
>   PM / devfreq: tegra30: Separate configurations per-SoC generation (2020-12-07 10:25:51 +0900)
>

Pulled, thanks!
