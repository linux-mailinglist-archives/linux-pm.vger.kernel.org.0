Return-Path: <linux-pm+bounces-36493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A45BF2C83
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFE318A7AD9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D33332ED0;
	Mon, 20 Oct 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoWOuH7p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B063321D7
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982276; cv=none; b=FiCe1X4S5wWgrZUk+ip/yx09Jr+5mJ3ZSwbHsacP7Dz5KhCQmKHUcR/uEJk4f/yIA1HrxIgxmc3ytcLPTDeYbS2DNWSo3baPa8xN6ksHShp7bi/rbjK7rwiS2Ci0VM+jeIQsHxbuu9foPYUgrmLNpBCRYSEz5XLt6bTPJJsdZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982276; c=relaxed/simple;
	bh=9SQduol4sq0EtS2GcOIwdhucDz3vZOy2iqkydjidjb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z97i4QBHFhu3AvWZLIJ/Te4RWFP4ozFGBfV6ocMlvjrpLyA0ddl+55nTPeuOOROTMrT5HRqNL6jTdpBJeaZLV+TzaF+GeX8RtXbQtk5TsCxeWDrIpVQPtnvaOrRxClBOCIu52BSAb37cXVusRXQVOUZIgAe5/7xrcc5PJdbdpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoWOuH7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34922C4CEF9
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982276;
	bh=9SQduol4sq0EtS2GcOIwdhucDz3vZOy2iqkydjidjb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XoWOuH7pqGKUuHsGV4vnJ9f2sK9s0qP/cnmrb8G+I/J68fBw1F7pqORh3JN/Fh3Tp
	 eOqfw6DVP/uLocyxy/H5lVzQDfvYG1m+yR7sJ0gbjEI5HJaRa2C+FbuGAVMNoFjNEM
	 tQRnaQOY1B+RmhajjkSLD8ZHgmDiQWC83ItxpM+FsoI/CojrO6RKudqeL7T5/jiIdM
	 jlwJxeWKEmgo8xgKwz9CHGclQ/3AGF/iOxsyP+tjDwcjzMKqOhI/ah22OuxBKSudzd
	 A1VmOL90BuYrfJafDdw8s57VpX+gsu3SwiLmgDCeTmXqXXPFU3sw8dajyGmHmjmX8Z
	 2RM0WNCFERl/w==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f802f8571so1279262b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 10:44:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVadmijn+Lxw06tCFt8MMuxKYiAYMruRVTvwSaN4yc5j4ct5YXA2oH33kWXvOoQc2msUPyRunCitw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqofz8Qlg4paKSTH3hJDGFyFwWsuteQh9aYEoT/eqw2XFo5Nt
	CuODsSJ08xly6wuqRG5/Cf/ebILU2yayZQkVt0DSHnaspNCMder7j0nX9hA6ntiGuUPB7MJlKcS
	RNJnywRwJDSQNwKJzhAsD48UhZTkMjyA=
X-Google-Smtp-Source: AGHT+IEwbvz72kNzUitB/HZRHnWBHktzWo+WHJ4wfWV7a7y7zEi7Xt1kb6kk+2+LndRg6PQI9iAqjmMQy+zxteny/jM=
X-Received: by 2002:a05:6808:190d:b0:438:8c9:5f4 with SMTP id
 5614622812f47-443a2edee81mr5446868b6e.19.1760982275490; Mon, 20 Oct 2025
 10:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014001055.772422-6-changwoo@igalia.com> <202510151232.UNZ2J7TZ-lkp@intel.com>
In-Reply-To: <202510151232.UNZ2J7TZ-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:44:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAnKEUP7n_d3bzVEi0HGmgZXC-+U=_RmS1n0wGniv8qQ@mail.gmail.com>
X-Gm-Features: AS18NWDqU8gI4O1WJOZVUI3zH0SqwXzI9Pu_KT0r6C5A7fFtSAxMeq04Q4UHq8s
Message-ID: <CAJZ5v0hAnKEUP7n_d3bzVEi0HGmgZXC-+U=_RmS1n0wGniv8qQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for the
 performance domain
To: kernel test robot <lkp@intel.com>, Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, oe-kbuild-all@lists.linux.dev, christian.loehle@arm.com, 
	tj@kernel.org, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:50=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Changwoo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on amd-pstate/linux-next]
> [also build test ERROR on amd-pstate/bleeding-edge linus/master v6.18-rc1=
 next-20251014]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Changwoo-Min/PM-EM=
-Assign-a-unique-ID-when-creating-a-performance-domain/20251014-082420
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git=
 linux-next
> patch link:    https://lore.kernel.org/r/20251014001055.772422-6-changwoo=
%40igalia.com
> patch subject: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for =
the performance domain
> config: i386-buildonly-randconfig-001-20251015 (https://download.01.org/0=
day-ci/archive/20251015/202510151232.UNZ2J7TZ-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251015/202510151232.UNZ2J7TZ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510151232.UNZ2J7TZ-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> kernel/power/energy_model.c:1003:5: error: redefinition of 'for_each_e=
m_perf_domain'
>     1003 | int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, =
void *),
>          |     ^~~~~~~~~~~~~~~~~~~~~~~
>    In file included from kernel/power/energy_model.c:20:
>    kernel/power/em_netlink.h:18:5: note: previous definition of 'for_each=
_em_perf_domain' with type 'int(int (*)(struct em_perf_domain *, void *), v=
oid *)'
>       18 | int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, =
void *),
>          |     ^~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/power/energy_model.c:1022:24: error: redefinition of 'em_perf_d=
omain_get_by_id'
>     1022 | struct em_perf_domain *em_perf_domain_get_by_id(int id)
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/power/em_netlink.h:24:24: note: previous definition of 'em_perf=
_domain_get_by_id' with type 'struct em_perf_domain *(int)'
>       24 | struct em_perf_domain *em_perf_domain_get_by_id(int id)
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>

Please update the patch to address this report and resend it, thanks!

> vim +/for_each_em_perf_domain +1003 kernel/power/energy_model.c
>
>   1002
> > 1003  int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, voi=
d *),
>   1004                              void *data)
>   1005  {
>   1006          struct em_perf_domain *pd;
>   1007
>   1008          lockdep_assert_not_held(&em_pd_mutex);
>   1009          guard(mutex)(&em_pd_list_mutex);
>   1010
>   1011          list_for_each_entry(pd, &em_pd_list, node) {
>   1012                  int ret;
>   1013
>   1014                  ret =3D cb(pd, data);
>   1015                  if (ret)
>   1016                          return ret;
>   1017          }
>   1018
>   1019          return 0;
>   1020  }
>   1021
> > 1022  struct em_perf_domain *em_perf_domain_get_by_id(int id)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

