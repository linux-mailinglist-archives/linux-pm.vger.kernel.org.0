Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E642AD5A0E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 05:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfJNDz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 23:55:58 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:42627 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbfJNDz5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 13 Oct 2019 23:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1571025357; x=1602561357;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=pOn1r0uMbFxPbRmdPlkJRD5BpRWveMVLcjOhf0EWA0w=;
  b=jkf58VGiDvtlFALkP4qChbjKKwfgL3Ri4zTlMbC8PxwRxzNoGtEaV0tX
   Nj0P4uqQiNtWhqOvjbXCBu8DP7s1GtSD6YOIBYszNv0IfsjGkieXzZGxD
   5xyOaDhO9jxKbEfr1kqseIIFTleVGCfvj3FEn+Ca9Wk1oGItE3ExwF4IE
   q+2EP/cHAvad5LE5fJtk5JaIjy2wcDHydSe3NGQpg1xeqLO+oMpAtD4N9
   eLrztWmSerT69Kfd58G0uodanN3fFgWg58GbJ/P1S1wyw1O5aCQ4ANrIR
   y1lP4Y+10izfsqvNZpA+vQdjwZQZkRDl5MRs5uS6bTn/xjKuBo8ZFC9Kt
   A==;
IronPort-SDR: 2zMqu5Vu/04hYNBWXGFfTPuU8gosusV4HulIcMznM4K8vrcCz9tW+fN83SMnF5C6snNAvVReyN
 vS8PmzkwdDsWXo86r96pYwafRMcihKOmCZHOIlBd6qqMJ7832gy81x4TfYttitYRTXdIPlYUuM
 x8Un/vJcHL3dSzuCdxJxsweKb0IGuBfVwTdehtUoiWTCCqfg1m4XnuoJ5gK+RpkUe44zuDdXkb
 ubUzkBDxJypT92K6fHTgynWBcmpo+Cte7esGLer5NFHqmfCi9VUt0dBoqqv4DbMsKkxNSSpSQx
 JzM=
IronPort-PHdr: =?us-ascii?q?9a23=3AXEJpahCsYKoqG9xNWuDcUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPv8psbcNUDSrc9gkEXOFd2Cra4d0KyJ6+u/ByQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhe7oRneusQUgIZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSW?=
 =?us-ascii?q?dHQ81fVTFOApmkYoQAAeoOP+ZWoYf+qVUTsxWxGRKhBP/zxjJSmnP6wbE23u?=
 =?us-ascii?q?YnHArb3AIgBdUOsHHModr3NacTUOC1zLTPzT7ebPxW2S3y6InVeR0mofCNXL?=
 =?us-ascii?q?JwftDQyUUzCw/IgE6dqZH5MDOPzOgCrXWU7/d5WO+plmUpqBlxryCxysswjo?=
 =?us-ascii?q?TFnIEYx1De+Sln3Io4Jse0RFN/bNOmFpZbqjuUOJFsQsw4RmFloCM6yrobtp?=
 =?us-ascii?q?GlZCUK05EnxwLHa/yAboiI/grvVOaPLjd8g3JoYLe/iAyz8Uik0+H8Usu03E?=
 =?us-ascii?q?tToipLj9XBsnIA2wbc6siATft98UOh1iiV2w/P7eFEJFg4lavdK5E/3r49jo?=
 =?us-ascii?q?QfvVjHEyPsm0j7jLWaels49uWr8ejrf7Hrq52EO49xkA7+M6AumsKlAeQ/Nw?=
 =?us-ascii?q?gDR2ia+OW81LL5/E31XKlGg/Mtn6nErJ/aP94XqbCkDA9Iyooj8QqwDy+60N?=
 =?us-ascii?q?QEmnkKNFZFeBOBj4j0NFDCOej4DfKkjlSynzdk2erGMqfiAprTNHjDlqnufb?=
 =?us-ascii?q?Jn505b0gozwoMX25UBMbwLKenvW0b3/ObVDxQ5Pgj8l/39Bf1+25kYVGbJBb?=
 =?us-ascii?q?WWZvD8q1iNs9MuMemRY8cnuD/8Y6w09f7njCdhwncAdrPv0JcKPiPrVs96Kl?=
 =?us-ascii?q?mUNCK/yuwKFn0H609nFLTn?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EGAgCL8aNdh8XQVdFmHgELHIFwC4N?=
 =?us-ascii?q?fMyqEJI5ggg+ZLIF7AQgBAQEOLwEBhEACgl8kNAkOAgMJAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQEIDQkIKYVAgjopAYM9AQEBAxIRVhALCwMKAgImAgIiEgEFARwGEyK?=
 =?us-ascii?q?DAIJ4BaQagQM8iyaBMohiAQkNgUgSeiiMDoIXg241PoQogyqCXgSBOQEBAZU?=
 =?us-ascii?q?vllcBBgKCEBSMVIhFG5lALYwUmzwPI4EvghIzGiV/BmeBTlAQFIFpjkwkMJE?=
 =?us-ascii?q?oAQE?=
X-IPAS-Result: =?us-ascii?q?A2EGAgCL8aNdh8XQVdFmHgELHIFwC4NfMyqEJI5ggg+ZL?=
 =?us-ascii?q?IF7AQgBAQEOLwEBhEACgl8kNAkOAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIK?=
 =?us-ascii?q?YVAgjopAYM9AQEBAxIRVhALCwMKAgImAgIiEgEFARwGEyKDAIJ4BaQagQM8i?=
 =?us-ascii?q?yaBMohiAQkNgUgSeiiMDoIXg241PoQogyqCXgSBOQEBAZUvllcBBgKCEBSMV?=
 =?us-ascii?q?IhFG5lALYwUmzwPI4EvghIzGiV/BmeBTlAQFIFpjkwkMJEoAQE?=
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; 
   d="scan'208";a="82528216"
Received: from mail-lj1-f197.google.com ([209.85.208.197])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2019 20:55:53 -0700
Received: by mail-lj1-f197.google.com with SMTP id e3so3026753ljj.16
        for <linux-pm@vger.kernel.org>; Sun, 13 Oct 2019 20:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2KVWmKIsjNyLmGyKFy55mcaTZ+9zn5g8XpBLCOjHvI=;
        b=UrZY034ZNFdbGMV8bjhCupfuCBGNzmD6RTdU/RN2Ewo0EiSQ7VUVboPewGgno/nEcT
         AO3qibByF5zGQgMyqn3gP49NSXLigTo0W1KvJKF+DGA5yQ3Q95G2iGERLHOBVkRa190J
         NuhlbabcoIoiosju0jaNYR72SjQQmLA2saB8odpD5By9svfvTy4s6CxxI+weQBsIJpT2
         0ZYUjMwWsxWuM221OqewDnP/wQIm6Cj5sgHkkH4CnpHw2nSZ8dxORTz5kPtTFll3NMkm
         5Ocjej+2zew4ZQw6caJ/zdLlEzdSisELe3J3flLZNKtqDxy7CWxb94ym3n+zzUuLOa0w
         H6Qw==
X-Gm-Message-State: APjAAAWSiJuclBBxmKMlb4w3qymq/XucZGfepjOMU9uQTefhhPOqf9u/
        jYtlSiVRMDvnyVTgHDNcRZ3FlaevUG3WbiRA61svCpe/eFtcZu7/bHFh0Fevwk3mwy23yMDiiIg
        st2HztJFW0FieTv2TcdBii8PAMZLZBeo8sqg2
X-Received: by 2002:a2e:9890:: with SMTP id b16mr16909125ljj.181.1571025352293;
        Sun, 13 Oct 2019 20:55:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqrE2yq/Vp75dQaJ47s/jCqRxd5GyxvhCgPQQ3aM9LvDtLLobNElr9bUoPbGK6Dqt6B7LnlW91qurjhvouo9U=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr16909116ljj.181.1571025352056;
 Sun, 13 Oct 2019 20:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLTicqk-ncY18j=UCZhCCugTVkPWKjkWZj9yEccUp3m8XQ@mail.gmail.com>
 <20191014031238.fqiytckizbrwntci@earth.universe>
In-Reply-To: <20191014031238.fqiytckizbrwntci@earth.universe>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sun, 13 Oct 2019 20:55:40 -0700
Message-ID: <CABvMjLTc8BasrnsOtRvj5zcUiyc6Qj3+sxH2Ox704qRT2GWwmA@mail.gmail.com>
Subject: Re: Potential uninitialized variables in power: supply: rt5033_battery:
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian:

Thanks for your explanation and I will send the patch accordingly.

On Sun, Oct 13, 2019 at 8:12 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Thu, Oct 03, 2019 at 09:21:44PM -0700, Yizhuo Zhai wrote:
> > drivers/power/supply/rt5033_battery.c:
> >
> > In function rt5033_battery_get_present(), variable "val" could be
> > uninitialized if regmap_read() returns -EINVAL. However, "val" is
> > used to decide the return value, which is potentially unsafe.
> >
> > Also, we cannot simply return -EINVAL in rt5033_battery_get_present()
> > because it's not an acceptable return value.
> >
> > Thanks for your time to check this case.
>
> Should be fine to just return false when regmap_read() fails.
> Will you prepare a patch for that?
>
> Thanks,
>
> -- Sebastian



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
