Return-Path: <linux-pm+bounces-43744-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGYZK2Z6qmkqSQEAu9opvQ
	(envelope-from <linux-pm+bounces-43744-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 07:55:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB021C339
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 07:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC6BE3011534
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 06:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E866371D07;
	Fri,  6 Mar 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q79/OmxY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FB371D00
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780127; cv=none; b=r3e6+0rfYlskoYOn/1Jk8AhHLbxwfL/ebEE/WgX8Avg455Pg2hu704aspvoC8dyQl+2jVCLvQ6K7a/9jyBGuUre7EnoDkK4HIvPl557l/fZCIMevptK09wYWub2BTPhJdIwYZ3a/uUVscfqiYdbGm+jDd0w6lpWUo6olTfULVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780127; c=relaxed/simple;
	bh=yHP/NYIbCCLTWuIe4vFzOVhL0C1U0S/OpzVwTdv/CSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtd6uIQZErYO97K7a+xeaFlxVd0U2Vrz6jLaIyivgBtAOPSH/rv8LdutrcGy/XxDCpswVIKMeBUSm1WUW+MczXFjueOUCrgEBwjK6TOphQZXJdSqF7ku9nN8ipr2ZNIOdEH0Qg6sBBDflLH5lJ6yMWnnPbTteZql4syWs7HVp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q79/OmxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80347C2BCB2
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772780127;
	bh=yHP/NYIbCCLTWuIe4vFzOVhL0C1U0S/OpzVwTdv/CSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q79/OmxY6Eo1PNX+yKu1uI3WtN+QTyKGjOifmXhz/c1Dlwica4bw/DDJGqdvbDRGd
	 MKWXIzGu5jn01darBCGMT7o9QwAG31wMqnzU//kn6lcUR1ik/+CD5VfUy5W5g0IgOU
	 zRw1Jv+ohuq2g2yjWSDROGyRrhPo99BZIUF+zWGRd796N6p+8JHDAHt+X9KB0sQTkY
	 Tx3EUzyCdIryBVYqKDSfkatFjaA2cqEYhULFr2Pltyz/MgYdxvuCTMOTp/yGsF41W8
	 yHfM6iH0U0MRON9m+M213qRVUY/5vIzCuYYM0WRkoHtpq1DIOgqQ4JRGedcQ4/oe1n
	 tYRE9EkhzfSLw==
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ca6595c8aso8682265d50.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 22:55:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXDVSkIhmQssCaUmNrLn29Y0qD4UgbH/NEmdKNI2qmEnhPJQm3ULxzSOfhtS+kkNOJGQLjr5A40A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVGger+ry1hxT2votDTZBwaQ8YrcoNThMRRD9Ux7f0RYVmzKl
	YhQPQbZXnXquMDfg32lhMznZg1CoJR3jpE1r6fN2pvPNFYS1fsEaRl2qjzaxxbs7KeozsZwYt2z
	XDzlaGIyC80bRZqonz+vF2vQliqu03l1iiXpMzj/+5A==
X-Received: by 2002:a53:ee57:0:b0:64c:f4fa:4030 with SMTP id
 956f58d0204a3-64d14147f3emr933485d50.25.1772780126658; Thu, 05 Mar 2026
 22:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306024608.1720991-1-youngjun.park@lge.com>
In-Reply-To: <20260306024608.1720991-1-youngjun.park@lge.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 5 Mar 2026 22:55:15 -0800
X-Gmail-Original-Message-ID: <CACePvbXVvPp_a89UFztZo5nGawpFea9t=NRisf468VcxHgkX7A@mail.gmail.com>
X-Gm-Features: AaiRm52ieeZPwVrniCvpmKfN24wjM0j1i-6iz_fJBunHQl3H8TI9XOCSfg6Tl1U
Message-ID: <CACePvbXVvPp_a89UFztZo5nGawpFea9t=NRisf468VcxHgkX7A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/swap, PM: hibernate: hold swap device reference
 across swap operation
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, kasong@tencent.com, 
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AAAB021C339
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43744-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,vger.kernel.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,lge.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 6:46=E2=80=AFPM Youngjun Park <youngjun.park@lge.com=
> wrote:
>
> Currently, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the type
> is acquired, subsequent slot allocations operate on a stale swap device.

Just from you above description, I am not sure how the bug is actually
triggered yet. That sounds possible. I want more detail.

Can you show me which code path triggered this bug?
e.g. Thread A wants to suspend, with this back trace call graph.
Then in this function foo() A grabs the swap device without holding a refer=
ence.
Meanwhile, thread B is performing a swap off while A is at function foo().

> Additionally, grabbing and releasing the swap device reference on every
> slot allocation is inefficient across the entire hibernation swap path.

If the swap entry is already allocated by the suspend code on that
swap device, the follow up allocation does not need to grab the
reference again because the swap device's swapped count will not drop
to zero until resume.

> Address these issues by holding the swap device reference from the point
> the swap device is looked up, and releasing it once at each exit path.
> This ensures the device remains valid throughout the operation and
> removes the overhead of per-slot reference counting.

I want to understand how to trigger the buggy code path first. It
might be obvious to you. It is not obvious to me yet.

> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
> Hi,
>
> This is a simple RFC quality patch to verify if this approach is suitable=
.
> Per Usama Arif's feedback regarding git bisectability,
> I have squashed the previous commits into this single patch.
>
> base-commit: ec96cb7e4c12ff5b474cf9ab66f2e9767953e448 (mm-new)
>
> RFC v1: https://lore.kernel.org/linux-mm/20260305202413.1888499-1-usama.a=
rif@linux.dev/T/#m3693d45180f14f441b6951984f4b4bfd90ec0c9d
>
>  include/linux/swap.h |  1 +
>  kernel/power/swap.c  | 12 +++++++---
>  kernel/power/user.c  |  9 +++++++-
>  mm/swapfile.c        | 55 ++++++++++++++++++++++----------------------
>  4 files changed, 45 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 7a09df6977a5..37bf7cf21594 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -442,6 +442,7 @@ extern bool swap_entry_swapped(struct swap_info_struc=
t *si, swp_entry_t entry);
>  extern int swp_swapcount(swp_entry_t entry);
>  struct backing_dev_info;
>  extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> +extern void put_swap_device_by_type(int type);
>  sector_t swap_folio_sector(struct folio *folio);
>
>  /*
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 2e64869bb5a0..c230b0fa5a5f 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -350,9 +350,10 @@ static int swsusp_swap_check(void)
>
>         hib_resume_bdev_file =3D bdev_file_open_by_dev(swsusp_resume_devi=
ce,
>                         BLK_OPEN_WRITE, NULL, NULL);
> -       if (IS_ERR(hib_resume_bdev_file))
> +       if (IS_ERR(hib_resume_bdev_file)) {
> +               put_swap_device_by_type(root_swap);
>                 return PTR_ERR(hib_resume_bdev_file);
> -
> +       }
>         return 0;
>  }
>
> @@ -418,6 +419,7 @@ static int get_swap_writer(struct swap_map_handle *ha=
ndle)
>  err_rel:
>         release_swap_writer(handle);
>  err_close:
> +       put_swap_device_by_type(root_swap);
>         swsusp_close();
>         return ret;
>  }
> @@ -480,8 +482,11 @@ static int swap_writer_finish(struct swap_map_handle=
 *handle,
>                 flush_swap_writer(handle);
>         }
>
> -       if (error)
> +       if (error) {
>                 free_all_swap_pages(root_swap);
> +               put_swap_device_by_type(root_swap);
> +       }
> +
>         release_swap_writer(handle);
>         swsusp_close();
>
> @@ -1647,6 +1652,7 @@ int swsusp_unmark(void)
>          * We just returned from suspend, we don't need the image any mor=
e.
>          */
>         free_all_swap_pages(root_swap);
> +       put_swap_device_by_type(root_swap);
>
>         return error;
>  }
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 4401cfe26e5c..9cb6c24d49ea 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -90,8 +90,11 @@ static int snapshot_open(struct inode *inode, struct f=
ile *filp)
>                         data->free_bitmaps =3D !error;
>                 }
>         }
> -       if (error)
> +       if (error) {
>                 hibernate_release();
> +               if (data->swap >=3D 0)
> +                       put_swap_device_by_type(data->swap);
> +       }
>
>         data->frozen =3D false;
>         data->ready =3D false;
> @@ -115,6 +118,8 @@ static int snapshot_release(struct inode *inode, stru=
ct file *filp)
>         data =3D filp->private_data;
>         data->dev =3D 0;
>         free_all_swap_pages(data->swap);
> +       if (data->swap >=3D 0)
> +               put_swap_device_by_type(data->swap);
>         if (data->frozen) {
>                 pm_restore_gfp_mask();
>                 free_basic_memory_bitmaps();
> @@ -235,6 +240,8 @@ static int snapshot_set_swap_area(struct snapshot_dat=
a *data,
>                 offset =3D swap_area.offset;
>         }
>
> +       if (data->swap >=3D 0)
> +               put_swap_device_by_type(data->swap);
>         /*
>          * User space encodes device types as two-byte values,
>          * so we need to recode them
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 915bc93964db..f505dd1f7571 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1860,6 +1860,10 @@ struct swap_info_struct *get_swap_device(swp_entry=
_t entry)
>         return NULL;
>  }
>
> +void put_swap_device_by_type(int type)
> +{
> +       percpu_ref_put(&swap_info[type]->users);
> +}
>  /*
>   * Free a set of swap slots after their swap count dropped to zero, or w=
ill be
>   * zero after putting the last ref (saves one __swap_cluster_put_entry c=
all).
> @@ -2085,30 +2089,28 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>                 goto fail;
>
>         /* This is called for allocating swap entry, not cache */
> -       if (get_swap_device_info(si)) {
> -               if (si->flags & SWP_WRITEOK) {
> -                       /*
> -                        * Try the local cluster first if it matches the =
device. If
> -                        * not, try grab a new cluster and override local=
 cluster.
> -                        */
> -                       local_lock(&percpu_swap_cluster.lock);
> -                       pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0=
]);
> -                       pcp_offset =3D this_cpu_read(percpu_swap_cluster.=
offset[0]);
> -                       if (pcp_si =3D=3D si && pcp_offset) {
> -                               ci =3D swap_cluster_lock(si, pcp_offset);
> -                               if (cluster_is_usable(ci, 0))
> -                                       offset =3D alloc_swap_scan_cluste=
r(si, ci, NULL, pcp_offset);
> -                               else
> -                                       swap_cluster_unlock(ci);
> -                       }
> -                       if (!offset)
> -                               offset =3D cluster_alloc_swap_entry(si, N=
ULL);
> -                       local_unlock(&percpu_swap_cluster.lock);
> -                       if (offset)
> -                               entry =3D swp_entry(si->type, offset);
> +       if (si->flags & SWP_WRITEOK) {
> +               /*
> +                * Try the local cluster first if it matches the device. =
If
> +                * not, try grab a new cluster and override local cluster=
.
> +                */
> +               local_lock(&percpu_swap_cluster.lock);
> +               pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0]);
> +               pcp_offset =3D this_cpu_read(percpu_swap_cluster.offset[0=
]);
> +               if (pcp_si =3D=3D si && pcp_offset) {
> +                       ci =3D swap_cluster_lock(si, pcp_offset);
> +                       if (cluster_is_usable(ci, 0))
> +                               offset =3D alloc_swap_scan_cluster(si, ci=
, NULL, pcp_offset);
> +                       else
> +                               swap_cluster_unlock(ci);
>                 }
> -               put_swap_device(si);
> +               if (!offset)
> +                       offset =3D cluster_alloc_swap_entry(si, NULL);
> +               local_unlock(&percpu_swap_cluster.lock);
> +               if (offset)
> +                       entry =3D swp_entry(si->type, offset);
>         }
> +
>  fail:
>         return entry;
>  }
> @@ -2116,14 +2118,10 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>  /* Free a slot allocated by swap_alloc_hibernation_slot */
>  void swap_free_hibernation_slot(swp_entry_t entry)
>  {
> -       struct swap_info_struct *si;
> +       struct swap_info_struct *si =3D __swap_entry_to_info(entry);
>         struct swap_cluster_info *ci;
>         pgoff_t offset =3D swp_offset(entry);
>
> -       si =3D get_swap_device(entry);
> -       if (WARN_ON(!si))
> -               return;
> -
>         ci =3D swap_cluster_lock(si, offset);
>         __swap_cluster_put_entry(ci, offset % SWAPFILE_CLUSTER);
>         __swap_cluster_free_entries(si, ci, offset % SWAPFILE_CLUSTER, 1)=
;
> @@ -2131,7 +2129,6 @@ void swap_free_hibernation_slot(swp_entry_t entry)
>
>         /* In theory readahead might add it to the swap cache by accident=
 */
>         __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
> -       put_swap_device(si);
>  }
>
>  /*
> @@ -2160,6 +2157,7 @@ int swap_type_of(dev_t device, sector_t offset)
>                         struct swap_extent *se =3D first_se(sis);
>
>                         if (se->start_block =3D=3D offset) {
> +                               get_swap_device_info(sis);

The function name swap_type_of() does not suggest that the function
should take a reference.  This is just about function naming. I am not
commenting on the function logic yet.

>                                 spin_unlock(&swap_lock);
>                                 return type;
>                         }
> @@ -2180,6 +2178,7 @@ int find_first_swap(dev_t *device)
>                 if (!(sis->flags & SWP_WRITEOK))
>                         continue;
>                 *device =3D sis->bdev->bd_dev;
> +               get_swap_device_info(sis);
You might consider moving this one line up.The typical usage pattern
is get the reference then operate on the stuff protected by the
reference count. Here the order does not really matter due to the
swap_lock protection.

Waiting for details on how to trigger the bug.

Chris

