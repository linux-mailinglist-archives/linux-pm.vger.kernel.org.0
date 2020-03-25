Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8A1924D0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 10:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgCYJ55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 05:57:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38856 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJ55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 05:57:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id w2so1537101oic.5;
        Wed, 25 Mar 2020 02:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrHDtRwPhSmDON/us38dmUQzHS32k9eLAFxKK6HSnl0=;
        b=DP5Pw4stLMIJ3D8u9E+sYOz+ggv19+wfz6lhCAXn9J/q33q40xLDZrQSjmxJDmjwBE
         8Tnb9BHJSb9wmbO5GJ94j3hoVDHOhtbzk+w1HMBVrrqhwbD2eZc597NxsIWgk3fDOT5/
         d8F+BmwYAK/83jBMeMB8JZe+vVk8bBs7rE/BOV2B5Zj0NT0CHJgUBa7HDqWeV8TLWg+C
         HieZTQZB1rRuPJ+EqpkSSWfSU+q78rX9KZasWs76i+0/DYP84s/fwLnU3uRisqGLQ1qo
         AAHYSqHCWwdz+jbIOr4b+vrF2i0JSYJSgdpCevoF4ljn6md7OLwvMybM051VZDhEpZ91
         j0Yg==
X-Gm-Message-State: ANhLgQ2Br9vXkzBJDuzDPCpHnU2+KYGp1DEIi8rfR4TWw6WTPP1v5ZX5
        q/4Nnn3T0S9pXF5ub7rogm8BgU19c7tGULEufek=
X-Google-Smtp-Source: ADFU+vty5QelQ9Rhdv8R71W76aSaOFGqdoguN3P+mdffL711qq/q5fywvQlk5Zp4b94WCLMPnyxxHbnfrLJNF+Yh9dw=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr1941750oic.110.1585130276966;
 Wed, 25 Mar 2020 02:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200324234525epcas1p28f4150423112c61645bc19e3742b22bf@epcas1p2.samsung.com>
 <21bd6b76-5a3e-96c1-4184-49e96ea5f594@samsung.com>
In-Reply-To: <21bd6b76-5a3e-96c1-4184-49e96ea5f594@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Mar 2020 10:57:45 +0100
Message-ID: <CAJZ5v0gDJkH=TBE4tFTz94rLoCCUnN1UNOpeYxRNPjf8uQsOsg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.7
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 12:45 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.7-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.7
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:
>
>   Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.7

Pulled, thanks!
