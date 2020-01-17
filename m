Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902741407EE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgAQK2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 05:28:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44970 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAQK2y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 05:28:54 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so21691772oia.11;
        Fri, 17 Jan 2020 02:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDb4Q0+hZEmpUHyJ58sIFBV1rQVFKf0GHq7e/+qq/Ec=;
        b=qJVCj+ywAmzeBAniebpB+ISn7j605qY8oOXqkiQuCvQQ3tmIbt6V9N1snu6peaYKoy
         nQ+vd04ihQ6d+bocrm2VuUsEF4lwJpXQrgELYKvo3d0fgum4VPg17MbO94EUTM5gdUIZ
         JYx5GKdbhFpf/1ln7U+9WP8KqWAcwsuiWjbdpzYUbIruQdvlZLONfhqsAXGKvVw8q7Ln
         TYOcWfPkKbmZqN5q/l8UubmX1/O71ZGU0gqBMflPOGCDDPYl7a8Iu0FL4BoBdS1iFx3q
         lxwGargjdL+3wGicJBkdTufX2BnUUXEo6qVyZnPsEcF6bpn5H32PlrkWYrlIiUN/r46/
         LmGw==
X-Gm-Message-State: APjAAAVWwMsZYPol4g0uwhrOpa568qlbfYqy8pM/Ny5szbm4TRRfli5P
        0L4MtGJFndXQoUHVPPdY/33Gag7M0r5M3+cNbJ4tIw==
X-Google-Smtp-Source: APXvYqziaLNisKwzuXE+4sPDjNUgpRCnJvjyKkzuhA7eI8Oll8NfuogDFcMFUusVtm44RvTNW++hHwmHsUtA9C2X3OI=
X-Received: by 2002:a54:488d:: with SMTP id r13mr2770861oic.115.1579256933826;
 Fri, 17 Jan 2020 02:28:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200117045233epcas1p4ec7b610173ad1536e340fd83aea3e4ed@epcas1p4.samsung.com>
 <ddb60cb0-5e54-3ed9-4d61-3098cc2d71d9@samsung.com>
In-Reply-To: <ddb60cb0-5e54-3ed9-4d61-3098cc2d71d9@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Jan 2020 11:28:42 +0100
Message-ID: <CAJZ5v0jh-Vap=m09AcRVY1EyMjb-Q-Kt69Wk-jUCga2qg7=EBg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.6
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 17, 2020 at 5:52 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.6-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.6
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:
>
>   Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.6

Pulled, thanks!
